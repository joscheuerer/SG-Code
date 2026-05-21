variable "name" {
  type        = string
  description = "Name of the public IP resource"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region where the public IP should exist"
}

variable "allocation_method" {
  type        = string
  description = "Allocation method for the public IP address (Static or Dynamic)"
}

variable "sku" {
  type        = string
  description = "SKU of the public IP (Basic, Standard, or StandardV2)"
}

variable "zones" {
  type        = list(string)
  description = "Availability zones for the public IP"
}