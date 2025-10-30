// Lightweight measure wrapper for CI steps
// Usage: node scripts/measureStep.js "step name" -- sf project:source:convert -r ./mdapi
// Or: node scripts/measureStep.js "sf project:source:convert" -- sf project:source:convert

const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

function nowIso() {
  return new Date().toISOString();
}

function kb(n) {
  return Math.round((n / 1024) * 10) / 10;
}

function ensureDirSync(dir) {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
}

function getTodayLogPath() {
  const d = new Date();
  const yyyy = d.getFullYear();
  const mm = String(d.getMonth() + 1).padStart(2, '0');
  const dd = String(d.getDate()).padStart(2, '0');
  return path.join('VibeWorkflowLogs', `${yyyy}-${mm}-${dd}-workflow-log.md`);
}

function appendMarkdownLog(mdLine) {
  const logPath = getTodayLogPath();
  ensureDirSync(path.dirname(logPath));
  if (!fs.existsSync(logPath)) {
    const header = `# Vibe Workflow Log - ${new Date().toISOString().substring(0, 10)}\n\n`;
    fs.writeFileSync(logPath, header, 'utf8');
  }
  fs.appendFileSync(logPath, mdLine + '\n', 'utf8');
}

function main() {
  const args = process.argv.slice(2);
  if (args.length < 2) {
    console.error('Usage: node scripts/measureStep.js "<stepName>" -- <command> [args...]');
    process.exit(2);
  }
  const sepIdx = args.indexOf('--');
  if (sepIdx === -1 || sepIdx === args.length - 1) {
    console.error('Missing "--" separator between stepName and command.');
    process.exit(2);
  }

  const stepName = args.slice(0, sepIdx).join(' ').trim();
  const cmdAndArgs = args.slice(sepIdx + 1);
  const cmd = cmdAndArgs[0];
  const cmdArgs = cmdAndArgs.slice(1);

  const start = Date.now();
  let stdoutBytes = 0;
  let stderrBytes = 0;

  const child = spawn(cmd, cmdArgs, { shell: true, stdio: ['ignore', 'pipe', 'pipe'] });

  child.stdout.on('data', (chunk) => {
    stdoutBytes += chunk.length;
    process.stdout.write(chunk);
  });
  child.stderr.on('data', (chunk) => {
    stderrBytes += chunk.length;
    process.stderr.write(chunk);
  });

  child.on('close', (code) => {
    const end = Date.now();
    const durationMs = end - start;

    const metric = {
      ts: nowIso(),
      step: stepName || cmdAndArgs.join(' '),
      command: [cmd, ...cmdArgs].join(' '),
      durationMs,
      exitCode: code,
      stdoutKB: kb(stdoutBytes),
      stderrKB: kb(stderrBytes),
    };

    const jsonLine = JSON.stringify(metric);
    // Emit a single-line metric for machine parsing
    console.log(`\n__VIBE_METRIC__ ${jsonLine}`);

    // Append to markdown log
    const md = [
      '---',
      `- Time: ${metric.ts}`,
      `- Step: ${metric.step}`,
      `- Command: \`${metric.command}\``,
      `- Duration: ${metric.durationMs} ms`,
      `- ExitCode: ${metric.exitCode}`,
      `- Out: ${metric.stdoutKB} KB / Err: ${metric.stderrKB} KB`,
      '',
      '```json',
      jsonLine,
      '```',
      '---',
      ''
    ].join('\n');
    appendMarkdownLog(md);

    process.exit(code ?? 1);
  });
}

main();
