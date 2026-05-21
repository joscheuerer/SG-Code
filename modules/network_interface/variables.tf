variable "name" {
  type        = string
  description = "Name of the network interface"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region where the NIC should exist"
}

variable "accelerated_networking_enabled" {
  type        = bool
  description = "Should accelerated networking be enabled"
}

variable "ip_forwarding_enabled" {
  type        = bool
  description = "Should IP forwarding be enabled"
}

variable "ip_configuration_name" {
  type        = string
  description = "Name of the IP configuration"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet for the NIC IP configuration"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "Private IP address allocation method (Dynamic or Static)"
}

variable "private_ip_address_version" {
  type        = string
  description = "IP version for the private IP address (IPv4 or IPv6)"
}

variable "public_ip_address_id" {
  type        = string
  description = "ID of the public IP address to associate with this NIC"
}

variable "ip_configuration_primary" {
  type        = bool
  description = "Is this the primary IP configuration"
}