# Terraform Azure Modules

## Intro

This repo serves to aggregate all useful modules to using in Azure.

## Modules

- [Network](https://azure.microsoft.com/en-us/products/category/networking/)
- [Azure Kubernetes Service](https://azure.microsoft.com/en-us/products/kubernetes-service/)

## Setup Azure Account

```bash
# First sign in on our Azure account
$ az login

You have logged in. Now let us find all the subscriptions to which you have access...

[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "0envbwi39-home-Tenant-Id",
    "id": "35akss-subscription-id",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Subscription-Name",
    "state": "Enabled",
    "tenantId": "0envbwi39-TenantId",
    "user": {
      "name": "your-username@domain.com",
      "type": "user"
    }
  }
]

# Setting your subscription id
$ az account set --subscription "35akss-subscription-id"

# Create a service principal
$ az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"

Creating 'Contributor' role assignment under scope '/subscriptions/35akss-subscription-id'
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx",
  "displayName": "azure-cli-2022-xxxx",
  "password": "xxxxxx~xxxxxx~xxxxx",
  "tenant": "xxxxx-xxxx-xxxxx-xxxx-xxxxx"
}

# Set your environment variables
$ export ARM_CLIENT_ID="<APPID_VALUE>"
$ export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
$ export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
$ export ARM_TENANT_ID="<TENANT_VALUE>"
```

## Config remote state

```bash
# Configure your remote state
$ RESOURCE_GROUP_NAME=tfstate
$ STORAGE_ACCOUNT_NAME=tfstate$RANDOM
$ CONTAINER_NAME=tfstate

# Create resource group
$ az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
$ az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
$ az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# Configure your backend before use Terraform
$ ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
$ export ARM_ACCESS_KEY=$ACCOUNT_KEY
```