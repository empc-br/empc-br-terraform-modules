# Network
variable "resource_group_name" {
  description = "The name of resource group to use in Network"
  type        = string
}

variable "network_name" {
  description = "The name of network."
  type        = string
  default     = ""
}

variable "address_space" {
  description = "The address space that is used the virtual network."
  type        = string
  default = ""
}

variable "address_spaces" {
  description = "The address space that is used the virtual network. List of address."
  type        = list(string)
  default     = []
}

variable "dns_servers" {
  description = "List of IP addresses of DNS servers."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)

  default = {
    "env" = "dev"
  }
}

# Subnets
variable "subnets_names" {
  description = "A list of subnets to configure."
  type        = list(string)
}

variable "subnets_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false."
  type        = map(bool)
  default     = {}
}

variable "subnet_service_endpoints" {
  description = "A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is []."
  type        = map(list(string))
  default     = {}
}