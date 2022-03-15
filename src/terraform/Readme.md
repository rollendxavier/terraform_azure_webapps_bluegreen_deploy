 # Terraform Scripts Creating App Service with Multi Stage Deployment Slots.
 
 ## Steps
Below are the steps needed to run scripts locally.

 ## Login to azure and set your subscription
 
 ``` cmd
 az login
 az account set -s <subscription id>
 ```
 
## Create a storage account & container for terraform state file (backend)

We have to manually create following resources, using the names configured in azure.conf

- Resource group

- Storage account

- Blob container

First we will create the resource group and the storage account
 ``` cmd
az group create -l australiasoutheast -n appservice-rg
az storage account create --resource-group appservice-rg --name appservice-store --sku Standard_LRS --encryption-services blob
 ```

We can list the storage account key to use it in container creation. 

``` cmd
az storage account keys list --account-name appservice-store 
az storage container create -n appservice-tf --account-name appservice_store --account-key <storage key>
 ```

## Init

``` cmd
terraform init -backend-config="azure.conf"
```

 ## Plan

``` cmd
 terraform plan --var-file=configs\apps.tfvars
 ```

 ## Apply

 ``` cmd
 terraform apply --var-file=configs\apps.tfvars
 ```