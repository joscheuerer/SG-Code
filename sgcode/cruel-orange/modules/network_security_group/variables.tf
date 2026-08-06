variable "name" {
  type        = string
  description = "Name of the network security group"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region where the NSG exists"
}

variable "security_rules" {
  type = list(object({
    name                       = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    access                     = string
    priority                   = number
    direction                  = string
  }))
  description = "List of custom security rules for the NSG"
  default     = []
}