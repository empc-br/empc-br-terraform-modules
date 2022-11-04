provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = var.resource_group_name
  location = var.location
}

module "aks" {
  source = "../../../modules/aks"

  prefix                 = "terratestAks"
  resource_group_name    = azurerm_resource_group.test.name
  cluster_name           = var.cluster_name
  default_node_pool_name = "default"
  dns_prefix             = "test"
  node_count             = var.node_count

  tags = {
    environment = "test"
    owner       = "empc-br"
  }

  log_analytics_workspace_enabled = false

  depends_on = [azurerm_resource_group.test]
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE KUBECONFIG FILE
# ---------------------------------------------------------------------------------------------------------------------

resource "local_file" "kubeconfig" {
  content  = module.aks.kube_config
  filename = "kubeconfig"

  depends_on = [module.aks]
}