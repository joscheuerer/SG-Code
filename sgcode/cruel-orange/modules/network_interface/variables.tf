variable "name" {
  type        = string
  description = "Name of the network interface"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region where the NIC exists"
}

variable "accelerated_networking_enabled" {
  type        = bool
  description = "Whether accelerated networking is enabled"
}

variable "ip_forwarding_enabled" {
  type        = bool
  description = "Whether IP forwarding is enabled"
}

variable "ip_config_name" {
  type        = string
  description = "Name of the IP configuration"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "Private IP address allocation method"
}

variable "private_ip_address_version" {
  type        = string
  description = "Private IP address version"
}

variable "public_ip_address_id" {
  type        = string
  description = "ID of the public IP address to associate"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet"
}

variable "ip_config_primary" {
  type        = bool
  description = "Whether this is the primary IP configuration"
}