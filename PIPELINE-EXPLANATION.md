# CI/CD Pipeline Explanation

This document provides a comprehensive explanation of the CI/CD pipeline implemented for this Salesforce project.

## Pipeline Components

### 1. GitHub Actions Workflow
- File: `.github/workflows/cicd-pipeline.yml`
- Trigger: Push to `main` or `develop` branches, or pull requests to `main`

### 2. Setup Instructions
- File: `CI-CD-SETUP-INSTRUCTIONS.md`
- Explains required secrets and configuration steps

## Pipeline Stages

### Stage 1: Build
- Checks out the source code from the repository
- Sets up Node.js environment (version 20)
- Installs Salesforce CLI and Salesforce DX CLI
- Authenticates with Salesforce Dev Hub using stored secrets

### Stage 2: Test
- Creates a temporary scratch org using the project's definition file
- Pushes all source code to the scratch org
- Executes all Apex tests in the project
- Reports test results

### Stage 3: Deploy (Conditional)
- If the code is pushed to the `main` branch, deploys to production org
- Uses the stored production username from secrets
- Provides detailed logging of deployment process

### Stage 4: Cleanup
- Always cleans up the scratch org, regardless of success or failure

## Security Considerations

### Secrets Management
- All sensitive information (Dev Hub credentials, Production credentials) is stored as GitHub Secrets
- No credentials are stored in the repository
- Secrets are accessed securely through GitHub Actions environment variables

### Access Control
- Only authorized users can modify repository secrets
- Pipeline runs with minimal required permissions

## Error Handling

### Robust Execution
- Each critical step includes `|| exit 1` to ensure pipeline fails fast on errors
- Proper cleanup occurs even if steps fail
- Detailed logs are available in GitHub Actions for debugging

## Branch Strategy

### Main Branch
- Triggers full pipeline including production deployment
- Used for stable releases

### Develop Branch  
- Triggers testing pipeline only
- Used for integration and feature development

### Pull Requests
- Triggers testing pipeline only
- Validates changes before merging

## Prerequisites

### Salesforce Setup
1. A Salesforce DX Dev Hub org
2. A Connected App configured with appropriate permissions
3. Optional: A production org for deployment

### GitHub Setup
1. Repository with write access
2. Required secrets configured in repository settings:
   - `DEV_HUB_USERNAME`
   - `CLIENT_ID` 
   - `PROD_USERNAME` (optional)

## Monitoring and Logging

### Available Information
- Full execution logs in GitHub Actions
- Test results and coverage reports
- Scratch org details and URLs
- Deployment status

### Viewing Results
1. Navigate to the **Actions** tab in your GitHub repository
2. Select the workflow run to view detailed logs
3. Check individual step results for troubleshooting

## Best Practices Implemented

### Automation
- Fully automated build, test, and deploy processes
- No manual intervention required for standard operations

### Consistency
- Standardized environment and execution across all runs
- Reproducible builds and deployments

### Reliability
- Error handling and graceful degradation
- Resource cleanup to prevent orphaned environments

## Customization Options

### Modifying the Pipeline
The workflow file can be customized to:
- Change trigger conditions
- Modify test execution parameters
- Add additional validation steps
- Include different deployment targets

### Extending Functionality
Consider adding:
- Code coverage thresholds
- Security scanning
- Performance testing
- Artifact storage
