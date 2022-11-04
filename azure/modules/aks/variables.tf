variable "prefix" {
  type        = string
  description = "(Required) The prefix for the resources created in the specified Azure Resource Group"
}

variable "resource_group_name" {
  type        = string
  description = "The name of resource group to use in AKS."
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster on AKS."
}

variable "dns_prefix" {
  type        = string
  description = "(Optional) DNS prefix specified when creating the managed cluster."
  default     = null
}

variable "kubernetes_version" {
  type        = string
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. "
  default     = null
}

variable "private_cluster_enabled" {
  type        = bool
  description = "(Optional) This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for this Kubernetes Cluster."
  default     = true
}

variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  description = "(Optional) The IP ranges to allow for incoming traffic to the server nodes."
  default     = null
}

# Default Node Pool variables
variable "default_node_pool_name" {
  type        = string
  description = "The name which should be used for the default Kubernetes Node Pool."
}

variable "vm_size" {
  type        = string
  description = "The size of the Virtual Machine"
  default     = "Standard_DS2_v2"
}

variable "enable_auto_scaling" {
  type        = bool
  description = "(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool."
  default     = false
}

# If enable_auto_scaling is set to true, then the following fields can also be configured
variable "max_count" {
  type        = number
  description = "Maximum number of nodes in a pool"
  default     = null
}

variable "min_count" {
  type        = number
  description = "Minimum number of nodes in a pool"
  default     = null
}

# If enable_auto_scaling is set to true or false, node_count is mandatory.
variable "node_count" {
  type        = number
  description = "(Optional) The initial number of nodes which should exist in this Node Pool."
  default     = 2
}

# If enable_auto_scaling is set to false, then the following fields can also be configured
variable "availability_zones" {
  type        = list(string)
  description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
  default     = null
}

# Back to normality
variable "enable_host_encryption" {
  type        = bool
  description = "(Optional) Should the nodes in the Default Node Pool have host encryption enabled."
  default     = false
}

variable "enable_node_public_ip" {
  type        = bool
  description = "(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false."
  default     = false
}

variable "max_pods" {
  type        = number
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  default     = null
}

variable "only_critical_addons_enabled" {
  type        = bool
  description = "(Optional) Enabling this option will taint default node pool with `CriticalAddonsOnly=true:NoSchedule` taint. Changing this forces a new resource to be created."
  default     = null
}

variable "ultra_ssd_enabled" {
  type        = bool
  description = "(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false."
  default     = false
}

variable "vnet_subnet_id" {
  type        = string
  description = "(Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  default     = null
}

# network_profile variables
variable "network_plugin" {
  type        = string
  description = "Network plugin to use for networking."
  default     = "kubenet"
  nullable    = false
}

variable "network_policy" {
  type        = string
  description = "(Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created."
  default     = null
}

variable "pod_cidr" {
  type        = string
  description = " (Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created."
  default     = null
}

variable "docker_bridge_cidr" {
  type        = string
  description = "(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_service_ip" {
  type        = string
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
  default     = null
}

variable "service_cidr" {
  type        = string
  description = "(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
  default     = null
}

# identity variables
variable "identity_type" {
  type        = string
  description = "(Optional) The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`(to enable both). If `UserAssigned` or `SystemAssigned, UserAssigned` is set, an `identity_ids` must be set as well."
  default     = "SystemAssigned"

  validation {
    condition     = var.identity_type == "SystemAssigned" || var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned"
    error_message = "`identity_type`'s possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`(to enable both)."
  }
}

# Tags
variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the AKS cluster resources"
  default     = {}
}

# Log Analytics variables
variable "location" {
  type        = string
  description = "Location of cluster or log analytics, if not defined it will be read from the resource-group"
  default     = null
}

variable "cluster_log_analytics_workspace_name" {
  type        = string
  description = "(Optional) The name of the Analytics workspace"
  default     = null
}

variable "log_analytics_solution_id" {
  type        = string
  description = "(Optional) Existing azurerm_log_analytics_solution ID. Providing ID disables creation of azurerm_log_analytics_solution."
  default     = null
  nullable    = true
}

variable "log_analytics_workspace" {
  type = object({
    id   = string
    name = string
  })
  description = "(Optional) Existing azurerm_log_analytics_workspace to attach azurerm_log_analytics_solution. Providing the config disables creation of azurerm_log_analytics_workspace."
  default     = null
  nullable    = true
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "(Optional) Resource group name to create azurerm_log_analytics_solution."
  default     = null
  nullable    = true
}

variable "log_analytics_workspace_enabled" {
  type        = bool
  description = "Enable the integration of azurerm_log_analytics_workspace and azurerm_log_analytics_solution: https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-onboard"
  default     = true
  nullable    = false
}

variable "log_analytics_workspace_sku" {
  type        = string
  description = "The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018"
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  type        = number
  description = "The retention period for the logs in days"
  default     = 30
}