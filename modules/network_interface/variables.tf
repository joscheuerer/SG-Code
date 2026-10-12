variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "ip_configurations" {
  type = list(object({
    name                          = string
    subnet_id                     = string
    private_ip_address_allocation = string
    public_ip_address_id          = optional(string)
    primary                       = optional(bool)
  }))
}

variable "accelerated_networking_enabled" {
  type    = bool
  default = false
}

variable "ip_forwarding_enabled" {
  type    = bool
  default = false
}

variable "network_security_group_id" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
