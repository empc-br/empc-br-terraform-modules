# Network outputs
output "virtual_network_id" {
  value = module.network.virtual_network_id
}

output "virtual_network_name" {
  value = module.network.virtual_network_name
}

output "virtual_network_location" {
  value = module.network.virtual_network_location
}

output "virtual_network_address_space" {
  value = module.network.virtual_network_address_space
}

output "virtual_network_subnets" {
  value = module.network.virtual_network_subnets
}