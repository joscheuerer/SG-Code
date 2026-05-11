variable "region" {
  description = "The Azure region where resources will be deployed"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "address_space" {
  description = "The address space used by the virtual network"
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "Map of subnets to create within the virtual network"
  type = map(object({
    name                              = string
    address_prefixes                  = list(string)
    private_endpoint_network_policies = string
  }))
  default = {}
}