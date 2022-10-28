output "virtual_network_id" {
  value = azurerm_virtual_network.virtual_network.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.virtual_network.name
}

output "virtual_network_location" {
  value = azurerm_virtual_network.virtual_network.location
}

output "virtual_network_address_space" {
  value = azurerm_virtual_network.virtual_network.address_space
}

output "virtual_network_subnets" {
  value = azurerm_subnet.virtual_network_subnet.*.id
}