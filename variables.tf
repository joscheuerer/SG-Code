variable "region" {
  type        = string
  description = "The Azure region to deploy resources into"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "virtual_network_resource_group_name" {
  type        = string
  description = "The resource group name for the virtual network"
}

variable "virtual_network_address_space" {
  type        = list(string)
  description = "The address space for the virtual network"
}

variable "virtual_network_tags" {
  type        = map(string)
  description = "Tags to assign to the virtual network"
  default     = {}
}

variable "network_security_groups" {
  type = map(object({
    name                = string
    resource_group_name = string
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
    tags = map(string)
  }))
  description = "Map of network security groups to create"
  default     = {}
}

variable "subnets" {
  type = map(object({
    name                              = string
    resource_group_name               = string
    address_prefixes                  = list(string)
    private_endpoint_network_policies = optional(string, "Enabled")
    delegation = list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    }))
    service_endpoints = list(string)
  }))
  description = "Map of subnets to create"
  default     = {}
}