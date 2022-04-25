# Terraform: Blue/Green deployment with Azure App Service for Containers
Azure App Service supports Blue/Green deployments using Deployment slots, where Azure Infrastructure resources are created using Terraform, pipelines using either GitHub actions or Azure DevOps.
## Requirements
* [.NET 5](https://docs.microsoft.com/en-us/dotnet/core/dotnet-five) installed and configured with your environment
* [Docker Desktop](https://docs.docker.com/docker-for-windows/install/) - minimum version 3.3.1.
* [Terraform](https://www.terraform.io/downloads) - version 1.1.9 or higher
* [Azure cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) - version 2.35.0. or higher.

Once the initial pre-requisites are installed, you can follow my [Medium Blog](https://rollendxavier.medium.com/terraform-blue-green-deployment-with-azure-app-service-for-containers-978f3cc6479f) to run and deploy this WebApp & Azure Container Registry using Terraform cli & Github Actions/Azure DevOps.
