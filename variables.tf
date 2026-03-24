variable "region" {
  type        = string
  description = "AWS region for the stack"
}

variable "subnets" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = optional(any, {})
  }))
  description = "Map of subnets to create"
}

variable "route_tables" {
  type = map(object({
    tags = optional(any, {})
  }))
  description = "Map of route tables to create"
}

variable "routes" {
  type = map(object({
    route_table_key        = string
    destination_cidr_block = string
    gateway_id             = string
  }))
  description = "Map of routes to create (excluding local routes)"
}

variable "route_table_associations" {
  type = map(object({
    route_table_key = string
    subnet_id       = string
  }))
  description = "Map of route table to subnet associations"
}

variable "network_acl_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to associate with the network ACL"
}

variable "network_acl_rules" {
  type = map(object({
    rule_number     = number
    egress          = bool
    protocol        = string
    rule_action     = string
    cidr_block      = optional(string)
    ipv6_cidr_block = optional(string)
  }))
  description = "Map of network ACL rules to create"
}