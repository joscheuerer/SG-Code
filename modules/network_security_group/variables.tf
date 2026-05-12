variable "name" {
  type        = string
  description = "The name of the network security group"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region where the NSG is created"
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "List of security rules to assign to the NSG"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the NSG"
}