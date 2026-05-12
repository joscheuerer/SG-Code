variable "name" {
  type        = string
  description = "The name of the subnet"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network to attach the subnet to"
}

variable "address_prefixes" {
  type        = list(string)
  description = "The address prefixes for the subnet"
}

variable "private_endpoint_network_policies" {
  type        = string
  description = "Enable or disable private endpoint network policies on the subnet"
  default     = "Enabled"
}

variable "delegation" {
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string))
    })
  }))
  description = "Optional delegation blocks for the subnet"
  default     = []
}

variable "service_endpoints" {
  type        = list(string)
  description = "List of service endpoints to associate with the subnet"
  default     = []
}