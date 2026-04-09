variable "name" {
  type        = string
  description = "Virtual network name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "address_space" {
  type        = list(string)
  description = "Virtual network address space"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "subnets" {
  type        = map(object({ address_prefix = string }))
  description = "Subnets to create"
  default     = {}
}