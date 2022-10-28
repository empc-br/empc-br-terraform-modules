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