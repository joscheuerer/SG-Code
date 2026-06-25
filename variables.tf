variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "network_interfaces" {
  description = "Map of Azure network interfaces to manage"
  type = map(object({
    name                           = string
    resource_group_name            = string
    location                       = string
    accelerated_networking_enabled = optional(bool, false)
    ip_forwarding_enabled          = optional(bool, false)
    tags                           = optional(map(string), {})
    ip_configurations = list(object({
      name                          = string
      private_ip_address            = string
      private_ip_address_version    = optional(string, "IPv4")
      private_ip_address_allocation = string
      primary                       = optional(bool, false)
      public_ip_address_id          = optional(string, null)
      subnet_id                     = string
    }))
  }))
  default = {}
}
