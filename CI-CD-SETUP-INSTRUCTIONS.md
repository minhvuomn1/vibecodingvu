# Build and Test Pipeline Setup Instructions

This document explains how to set up the simplified build and test pipeline for this Salesforce project.

## Overview

The build and test pipeline includes two main stages:
1. **Build** - Checks out the code and sets up the environment
2. **Test** - Lints code and runs Apex tests

## Required GitHub Secrets

Before the pipeline can run, you need to configure the following GitHub secrets in your repository settings:

### For Dev Hub Authentication
- `DEV_HUB_USERNAME` - Your Salesforce DX Dev Hub username
- `CLIENT_ID` - Your Connected App Client ID
- `CLIENT_SECRET` - Your Connected App Client Secret (required for JWT auth)

### For Production Deployment (Optional)
- `PROD_USERNAME` - Your production org username (only needed if deploying to prod)

## Setting up GitHub Secrets

1. Go to your repository on GitHub
2. Click on **Settings** tab
3. In the left sidebar, click on **Secrets and variables** → **Actions**
4. Click **New repository secret**
5. Add each secret with the corresponding name and value

## Pipeline Workflow Details

The workflow file `.github/workflows/cicd-pipeline.yml` defines the following jobs:

### Job: build-test-deploy
- Runs on Ubuntu latest runner
- Checks out the code
- Sets up Node.js environment
- Installs Salesforce CLI
- Authenticates with Dev Hub using stored secrets
- Creates a scratch org
- Pushes source code to scratch org
- Runs all Apex tests
- If on main branch, deploys to production
- Cleans up scratch org regardless of success/failure

## Testing the Pipeline

1. Push code to `main` or `develop` branch to trigger the full pipeline
2. Create a pull request to `main` branch to trigger testing only
3. Check the **Actions** tab in your GitHub repository to monitor progress

## Troubleshooting

### Common Issues:
- **Authentication failed**: Verify your Dev Hub username and client ID secrets are correct
- **Test failures**: Review test results in the workflow logs
- **Deployment failures**: Check production org credentials if deploying to prod

### Logs Location:
All logs and outputs are available in the **Actions** tab of your GitHub repository under the specific workflow run.
