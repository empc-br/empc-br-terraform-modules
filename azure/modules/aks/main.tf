data "azurerm_resource_group" "rg_aks" {
  name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                            = var.cluster_name
  location                        = data.azurerm_resource_group.rg_aks.location
  resource_group_name             = data.azurerm_resource_group.rg_aks.name
  dns_prefix                      = var.dns_prefix
  kubernetes_version              = var.kubernetes_version
  private_cluster_enabled         = var.private_cluster_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  default_node_pool {
    name                         = var.default_node_pool_name
    vm_size                      = var.vm_size
    enable_auto_scaling          = var.enable_auto_scaling
    max_count                    = var.max_count
    min_count                    = var.min_count
    node_count                   = var.node_count
    zones                        = var.availability_zones
    enable_host_encryption       = var.enable_host_encryption
    enable_node_public_ip        = var.enable_node_public_ip
    max_pods                     = var.max_pods
    only_critical_addons_enabled = var.only_critical_addons_enabled
    orchestrator_version         = var.kubernetes_version
    tags                         = var.tags
    type                         = "VirtualMachineScaleSets"
    ultra_ssd_enabled            = var.ultra_ssd_enabled
    vnet_subnet_id               = var.vnet_subnet_id
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    pod_cidr           = var.pod_cidr
    docker_bridge_cidr = var.docker_bridge_cidr
    dns_service_ip     = var.dns_service_ip
    service_cidr       = var.service_cidr
    load_balancer_sku  = "standard"
  }

  identity {
    type = var.identity_type
  }

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  count = local.create_analytics_workspace ? 1 : 0

  location            = coalesce(var.location, data.azurerm_resource_group.rg_aks.location)
  name                = var.cluster_log_analytics_workspace_name == null ? "${var.prefix}-workspace" : var.cluster_log_analytics_workspace_name
  resource_group_name = coalesce(var.log_analytics_workspace_resource_group_name, var.resource_group_name)
  retention_in_days   = var.log_retention_in_days
  sku                 = var.log_analytics_workspace_sku
  tags                = var.tags
}

locals {
  azurerm_log_analytics_workspace_id   = try(azurerm_log_analytics_workspace.log_analytics_workspace[0].id, null)
  azurerm_log_analytics_workspace_name = try(azurerm_log_analytics_workspace.log_analytics_workspace[0].name, null)
}

resource "azurerm_log_analytics_solution" "log_analytics_solution" {
  count = local.create_analytics_solution ? 1 : 0

  location              = coalesce(var.location, data.azurerm_resource_group.rg_aks.location)
  resource_group_name   = coalesce(var.log_analytics_workspace_resource_group_name, var.resource_group_name)
  solution_name         = "ContainerInsights"
  workspace_name        = local.log_analytics_workspace.name
  workspace_resource_id = local.log_analytics_workspace.id
  tags                  = var.tags

  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
}