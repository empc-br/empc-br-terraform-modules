# empc-br-terraform-modules - Azure Network

## Create a basic network in Azure
---
This Terraform module deploys a Virtual Network with a subnet or a set of subnets.

The module does not created or expose a security group yet.

## Usage in Terraform
---
```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "empc-test-rg"
  location = "eastus"
}

module "network" {
  source = "github.com/empc-br/empc-br-terraform-modules"

  resource_group_name = azurerm_resource_group.test.name
  network_name        = "empc-test-nw"
  address_spaces      = ["10.0.0.0/16", "10.2.0.0/16"]
  subnets_names       = ["subnet1", "subnet2", "subnet3"]
  subnets_prefixes    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_enforce_private_link_endpoint_network_policies = {
    "subnet1" : true
  }

  subnet_service_endpoints = {
    "subnet1" : ["Microsoft.ContainerRegistry"]
  }

  tags = {
    environment = "test"
    owner       = "empc-br"
  }

  depends_on = [azurerm_resource_group.test]
}
```

## Testing
---
```bash
$ cd ./tests
$ go test -v
```