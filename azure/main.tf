provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source = "./modules/network"

  resource_group_name = var.resource_group_name
  network_name        = var.network_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags
  subnets_names       = var.subnets_names
  subnets_prefixes    = var.subnets_prefixes

  depends_on = [azurerm_resource_group.rg]
}
