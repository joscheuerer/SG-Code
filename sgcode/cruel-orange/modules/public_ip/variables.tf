variable "name" {
  type        = string
  description = "Name of the public IP"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region where the public IP exists"
}

variable "allocation_method" {
  type        = string
  description = "Allocation method for the public IP"
}

variable "sku" {
  type        = string
  description = "SKU of the public IP"
}

variable "ip_version" {
  type        = string
  description = "IP version for the public IP"
}

variable "zones" {
  type        = list(string)
  description = "Availability zones for the public IP"
}