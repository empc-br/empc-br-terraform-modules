locals {
  create_analytics_solution  = var.log_analytics_workspace_enabled && var.log_analytics_solution_id == null
  create_analytics_workspace = var.log_analytics_workspace_enabled && var.log_analytics_workspace == null
  log_analytics_workspace = var.log_analytics_workspace_enabled ? (
    # The Log Analytics Workspace should be enabled:
    var.log_analytics_workspace == null ? {
      id   = local.azurerm_log_analytics_workspace_id
      name = local.azurerm_log_analytics_workspace_name
      } : {
      id   = var.log_analytics_workspace.id
      name = var.log_analytics_workspace.name
    }
  ) : null
}