variable "region" {
  description = "The Azure region where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space used by the virtual network"
  type        = list(string)
}

variable "virtual_network_tags" {
  description = "A mapping of tags to assign to the virtual network"
  type        = map(string)
}

variable "subnets" {
  description = "Map of subnets to create within the virtual network, keyed by subnet name"
  type = map(object({
    address_prefixes                  = list(string)
    private_endpoint_network_policies = optional(string, "Enabled")
  }))
}