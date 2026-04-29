variable "name" {
  description = "The name of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network"
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual network is created"
  type        = string
}

variable "address_space" {
  description = "The address space used by the virtual network"
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the virtual network"
  type        = map(string)
}

variable "subnets" {
  description = "Map of subnets to create within the virtual network, keyed by subnet name"
  type = map(object({
    address_prefixes                  = list(string)
    private_endpoint_network_policies = optional(string, "Enabled")
  }))
  default = {}
}