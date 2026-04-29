variable "name" {
  type        = string
  description = "Name of the network interface"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for the NIC"
}

variable "location" {
  type        = string
  description = "Azure region for the NIC"
}

variable "accelerated_networking_enabled" {
  type        = bool
  description = "Whether accelerated networking is enabled"
}

variable "ip_forwarding_enabled" {
  type        = bool
  description = "Whether IP forwarding is enabled"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet for the NIC ip configuration (external reference)"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the NIC"
}