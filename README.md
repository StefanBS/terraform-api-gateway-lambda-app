# Hello world HTTP APP using Lambda + API Gateway
## Requirements
```
We would like you to deploy a simple "hello world" http app in AWS, using Api Gateway and Lambda.
Now it is up to you to write the code!
For the infrastructure code, use terraform.
For the application code, you can use choose which language to use.
The challenge is to write the code.
If you have an AWS account you can also deploy it, but this is not required!
Extra points: Add CI/CD to your deployment.
```

## Solution
This solution implements a simple HTTP API in API Gateway and a zip code deployed Lambda. We use GitHub actions for CI/CD.

### Notes
- Terraform is used for initial code deployment but it's NOT used for code management. For subsequent Terraform runs changes to code are ignored.
- A GitHub actions workflow is triggered every time there's a commit to `main` with changes to `./src` directory
- For CI/CD integration to work you need to [setup OIDC integration](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)

### Improvements
- Automate Terraform pull requests with a tool like [Atlantis](https://www.runatlantis.io/)
- Setup a security scanner like [Trivy](https://github.com/aquasecurity/trivy) to run on pull requests
