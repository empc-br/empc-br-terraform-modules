# Azure generic network module
data "azurerm_resource_group" "rg_network" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = var.network_name
  resource_group_name = data.azurerm_resource_group.rg_network.name
  location            = data.azurerm_resource_group.rg_network.location
  address_space       = length(var.address_spaces) == 0 ? [var.address_space] : var.address_spaces
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "virtual_network_subnet" {
  count                                          = length(var.subnets_names)
  name                                           = var.subnets_names[count.index]
  resource_group_name                            = data.azurerm_resource_group.rg_network.name
  address_prefixes                               = [var.subnets_prefixes[count.index]]
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  enforce_private_link_endpoint_network_policies = lookup(var.subnet_enforce_private_link_endpoint_network_policies, var.subnets_names[count.index], false)
  service_endpoints                              = lookup(var.subnet_service_endpoints, var.subnets_names[count.index], [])
}
