variable "name" {
  type        = string
  description = "Name of the network security group"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for the NSG"
}

variable "location" {
  type        = string
  description = "Azure region for the NSG"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the NSG"
}