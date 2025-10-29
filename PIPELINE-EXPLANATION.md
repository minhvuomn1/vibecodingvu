# CI/CD Pipeline Setup Instructions

This project uses a GitHub Actions workflow for automated building and testing. The workflow is defined in `.github/workflows/cicd-pipeline.yml`.

## Authentication Setup

To enable the workflow to connect to your Salesforce Production org, you need to configure the following GitHub Secrets in your repository settings:

### Required Secrets:
1. `SALESFORCE_USERNAME` - Your Salesforce Production org username
2. `SALESFORCE_CLIENT_ID` - Your Connected App's Client ID
3. `SALESFORCE_CLIENT_SECRET` - Your Connected App's Client Secret  
4. `SALESFORCE_JWT_KEY` - Your Connected App's private key (in PEM format)

## Setting Up Connected App for JWT Authentication

To create the required Connected App and obtain the necessary credentials:

1. **In your Salesforce Production org:**
   - Navigate to Setup → App Manager
   - Click "New Connected App"
   - Fill in the required fields:
     - Connected App Name: `GitHub Actions`
     - API Name: `GitHub_Actions`
     - Contact Email: [your email]
   - Enable OAuth Settings:
     - Check "Enable OAuth Settings"
     - Callback URL: `https://login.salesforce.com/`
     - Selected OAuth Scopes: 
       - Access and manage your data (api)
       - Perform requests on your behalf at any time (refresh_token, offline_access)
       - Provide access to your data via the Web Services API (web)
   - Click "Save"

2. **Configure Digital Certificate:**
   - In the Connected App settings, click "Manage" next to "Digital Certificates"
   - Generate a new certificate
   - Download the private key (PEM format)
   - Copy the Client ID from the Connected App details


## Workflow Execution

The workflow will automatically trigger on:
- Push events to `main` or `develop` branches
- Pull request events targeting the `main` branch

## Testing the Setup

To verify the workflow works correctly:
1. Commit and push your changes to the repository
2. Visit the "Actions" tab in your GitHub repository
3. The workflow should automatically start
4. Monitor the execution logs to ensure authentication and test execution succeed

## Alternative: Using Scratch Orgs

If you prefer to use a scratch org instead of the production org, you can modify the workflow to:
1. Create a scratch org using `sf org create scratch`
2. Run tests against the scratch org
3. Delete the scratch org after testing

This approach is often preferred for CI/CD as it provides a clean, isolated environment for each test run.
