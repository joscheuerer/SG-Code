variable "name" {
  type        = string
  description = "The name of the virtual network"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region where the virtual network is created"
}

variable "address_space" {
  type        = list(string)
  description = "The address space used by the virtual network"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the virtual network"
}