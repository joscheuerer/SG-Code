variable "name" {
  type        = string
  description = "The name of the Network Interface"
}

variable "location" {
  type        = string
  description = "The Azure region where the Network Interface should exist"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which to create the Network Interface"
}

variable "accelerated_networking_enabled" {
  type        = bool
  description = "Should Accelerated Networking be enabled"
}

variable "ip_forwarding_enabled" {
  type        = bool
  description = "Should IP Forwarding be enabled"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}

variable "ip_configuration_name" {
  type        = string
  description = "Name used for the IP Configuration"
}

variable "private_ip_address_version" {
  type        = string
  description = "The IP Version to use for the IP Configuration"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "The allocation method used for the Private IP Address"
}

variable "private_ip_address" {
  type        = string
  description = "The static private IP address"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet where this Network Interface should be located"
}

variable "public_ip_address_id" {
  type        = string
  description = "The ID of the Public IP Address to associate with this NIC"
}

variable "ip_configuration_primary" {
  type        = bool
  description = "Is this the Primary IP Configuration"
}