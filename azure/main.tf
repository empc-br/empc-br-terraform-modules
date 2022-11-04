provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
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

module "aks" {
  source = "./modules/aks"

  # General variables
  prefix              = var.prefix
  resource_group_name = azurerm_resource_group.rg.name
  cluster_name        = var.cluster_name
  dns_prefix          = var.dns_prefix
  # kubernetes_version              = var.kubernetes_version
  private_cluster_enabled         = var.private_cluster_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  # Default Node Pool variables
  default_node_pool_name = var.default_node_pool_name
  vm_size                = var.vm_size
  enable_auto_scaling    = var.enable_auto_scaling
  max_count              = var.max_count
  min_count              = var.min_count
  node_count             = var.node_count
  # availability_zones           = var.availability_zones
  enable_host_encryption       = var.enable_host_encryption
  enable_node_public_ip        = var.enable_node_public_ip
  max_pods                     = var.max_pods
  only_critical_addons_enabled = var.only_critical_addons_enabled
  ultra_ssd_enabled            = var.ultra_ssd_enabled
  # vnet_subnet_id               = module.network.virtual_network_subnets

  # Network Profile variables
  network_plugin     = var.network_plugin
  network_policy     = var.network_policy
  pod_cidr           = var.pod_cidr
  docker_bridge_cidr = var.docker_bridge_cidr
  dns_service_ip     = var.dns_service_ip
  service_cidr       = var.service_cidr

  # Identity variable
  identity_type = var.identity_type

  depends_on = [module.network]
}