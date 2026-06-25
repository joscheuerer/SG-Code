variable "name" {
  description = "Name of the network interface"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "accelerated_networking_enabled" {
  description = "Enable accelerated networking"
  type        = bool
  default     = false
}

variable "ip_forwarding_enabled" {
  description = "Enable IP forwarding"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the network interface"
  type        = map(string)
  default     = {}
}

variable "ip_configurations" {
  description = "List of IP configurations for the network interface"
  type = list(object({
    name                          = string
    private_ip_address            = string
    private_ip_address_version    = optional(string, "IPv4")
    private_ip_address_allocation = string
    primary                       = optional(bool, false)
    public_ip_address_id          = optional(string, null)
    subnet_id                     = string
  }))
}
