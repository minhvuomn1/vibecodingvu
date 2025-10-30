# CI Workflow với Vibe

Tài liệu này mô tả cách thiết lập CI cho dự án Salesforce với mục tiêu:
- Đo hiệu năng (thời gian) và lỗi của bước generate metadata: `sf project:source:convert`
- Ghi log theo ngày trong thư mục `VibeWorkflowLogs/`
- Tổng hợp số liệu trung bình và số lỗi ngay trong GitHub Actions Summary
- Tuân thủ yêu cầu: dùng `sf` (không dùng `sfdx`)

Nội dung:
1) Kiến trúc CI tổng quan
2) Thiết lập đo hiệu năng cho `sf project:source:convert`
3) Ghi nhận thời gian trung bình & lỗi
4) Cấu hình GitHub Actions mẫu
5) Khắc phục sự cố

---

1) Kiến trúc CI tổng quan
- Bước chuẩn bị:
  - Checkout repository
  - Cài Node.js 20
  - Cài Salesforce CLI (`@salesforce/cli`) và plugins cần thiết
  - Auth vào Org (dùng SFDX Auth URL từ GitHub Secrets)
- Bước build/validate/deploy:
  - Đo thời gian và lỗi cho bước generate metadata bằng lệnh `sf project:source:convert`
  - Deploy/validate (tùy pipeline)
- Bước tổng hợp:
  - Parse log JSON trong `VibeWorkflowLogs/YYYY-MM-DD-workflow-log.md`
  - Tính trung bình thời gian, số lần lỗi
  - Upload artifacts (`VibeWorkflowLogs/`)

2) Thiết lập đo hiệu năng cho `sf project:source:convert`
- Script đo: `scripts/measureStep.js`
  - Cách dùng:
    - node scripts/measureStep.js "sf project:source:convert (mdapi out)" -- sf project:source:convert --output-dir mdapi
  - Chức năng:
    - Bọc lệnh cần đo, tính `durationMs`, đếm `stdoutKB`/`stderrKB`, ghi `exitCode`
    - In ra 1 dòng JSON có tiền tố `__VIBE_METRIC__`
    - Append block markdown vào `VibeWorkflowLogs/YYYY-MM-DD-workflow-log.md`
    - Trả lại exit code của lệnh bên trong để CI fail nếu lệnh fail

Ví dụ JSON metric:
{
  "ts": "2025-10-30T03:40:00.123Z",
  "step": "sf project:source:convert (mdapi out)",
  "command": "sf project:source:convert --output-dir mdapi",
  "durationMs": 182345,
  "exitCode": 0,
  "stdoutKB": 64.3,
  "stderrKB": 0.7
}

3) Ghi nhận thời gian trung bình & lỗi
- Pipeline sẽ đọc file log của ngày hiện tại trong `VibeWorkflowLogs/`
- Lọc các dòng chứa `__VIBE_METRIC__` và parse JSON
- Lọc theo `step` chứa `project:source:convert`
- Tính:
  - Average duration (ms) = tổng durationMs / số lần chạy
  - Errors = số metric có `exitCode != 0`
- In summary ra log của job (hiển thị trong Actions UI)

4) Cấu hình GitHub Actions mẫu
- File: `.github/workflows/cicd-pipeline-simple.yml`
- Các điểm chính đã được cập nhật:
  - Dùng `npm install --global @salesforce/cli` và `sf` thay cho `sfdx`
  - Bước đo convert:
    - name: Measure Convert (sf project:source:convert)
      run: node scripts/measureStep.js "sf project:source:convert (mdapi out)" -- sf project:source:convert --output-dir mdapi
  - Bước tổng hợp:
    - Đọc `VibeWorkflowLogs/YYYY-MM-DD-workflow-log.md`, tính average & errors
    - Upload artifact `VibeWorkflowLogs/`

Yêu cầu Secrets:
- `SFDX_AUTH_URL`: URL đăng nhập SFDX (sử dụng cho `sf auth sfdx-url store` để set default org)

5) Khắc phục sự cố
- Lỗi cài CLI:
  - Đảm bảo runner có quyền cài global npm package
  - Kiểm tra `sf --version` sau khi cài
- Lỗi auth:
  - Kiểm tra secret `SFDX_AUTH_URL` hợp lệ
  - Xác nhận alias `hellovibe-dev` tồn tại sau khi auth (`sf org display --target-org hellovibe-dev`)
- Lỗi convert:
  - Kiểm tra cấu trúc `sfdx-project.json`, đường dẫn `force-app`
  - Thử chạy local: `sf project:source:convert --output-dir mdapi`
- Không thấy log:
  - Đảm bảo bước đo đã chạy ít nhất một lần trong ngày
  - Kiểm tra file `VibeWorkflowLogs/YYYY-MM-DD-workflow-log.md` trong artifact
- Trung bình = 0 hoặc không có metrics:
  - Có thể ngày đó pipeline không chạy bước đo
  - Kiểm tra grep `__VIBE_METRIC__` có dữ liệu

Phụ lục: Lệnh hữu ích
- Chạy đo local (Windows PowerShell ví dụ):
  - node .\scripts\measureStep.js "convert local" -- sf project:source:convert --output-dir mdapi
- Dọn output mdapi:
  - rm -rf mdapi (Linux/macOS)
  - Remove-Item -Recurse -Force mdapi (PowerShell)

Tuân thủ quy tắc Salesforce:
- Luôn dùng `sf` thay vì `sfdx`
- Ưu tiên MCP tools của Salesforce CLI nếu có sẵn trong môi trường (tham khảo nội bộ)
- Đảm bảo metadata files (.object-meta.xml, .cls-meta.xml, .trigger-meta.xml) luôn được version control đầy đủ
