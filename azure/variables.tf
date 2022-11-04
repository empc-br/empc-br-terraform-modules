# Global variables
variable "resource_group_name" {
  description = "The name of resource group to use in resources."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "The location of resource group to use in resources."
  type        = string
  default     = "eastus"
}

# Network variables
variable "network_name" {
  description = "The name of network."
  type        = string
  default     = "vnet1"
}

variable "address_space" {
  description = "The address space that is used the virtual network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_servers" {
  description = "List of IP addresses of DNS servers."
  type        = list(string)
  default     = ["10.0.0.4", "10.0.0.5"]
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)

  default = {
    "owner" = "empc-br"
  }
}

variable "subnets_names" {
  description = "A list of subnets to configure."
  type        = list(string)
  default     = ["subnet1", "subnet2"]
}

variable "subnets_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# AKS variables
variable "prefix" {
  type        = string
  description = "(Required) The prefix for the resources created in the specified Azure Resource Group"
  default     = "empc"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster on AKS."
  default     = "empc-cluster"
}

variable "dns_prefix" {
  type        = string
  description = "(Optional) DNS prefix specified when creating the managed cluster."
  default     = "test-empc"
}

# variable "kubernetes_version" {
#   type        = string
#   description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. "
#   default     = "1.22"
# }

variable "private_cluster_enabled" {
  type        = bool
  description = "(Optional) This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located."
  default     = true
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
  default     = "default"
}

variable "vm_size" {
  type        = string
  description = "The size of the Virtual Machine"
  default     = "Standard_DS2_v2"
}

variable "enable_auto_scaling" {
  type        = bool
  description = "(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool."
  default     = true
}

variable "max_count" {
  type        = number
  description = "Maximum number of nodes in a pool"
  default     = 10
}

variable "min_count" {
  type        = number
  description = "Minimum number of nodes in a pool"
  default     = 2
}

variable "node_count" {
  type        = number
  description = "(Optional) The initial number of nodes which should exist in this Node Pool."
  default     = 2
}

# variable "availability_zones" {
#   type        = list(string)
#   description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
#   default     = null
# }

variable "enable_host_encryption" {
  type        = bool
  description = "(Optional) Should the nodes in the Default Node Pool have host encryption enabled."
  default     = false
}

variable "enable_node_public_ip" {
  type        = bool
  description = "(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false."
  default     = true
}

variable "max_pods" {
  type        = number
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  default     = 30
}

variable "only_critical_addons_enabled" {
  type        = bool
  description = "(Optional) Enabling this option will taint default node pool with `CriticalAddonsOnly=true:NoSchedule` taint. Changing this forces a new resource to be created."
  default     = true
}

variable "ultra_ssd_enabled" {
  type        = bool
  description = "(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false."
  default     = false
}

# Network Policies Variables
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
}