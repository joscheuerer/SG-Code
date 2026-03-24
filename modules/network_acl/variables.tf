variable "default_network_acl_id" {
  type        = string
  description = "The ID of the default network ACL"
}

variable "ingress_rules" {
  type = list(object({
    protocol   = string
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
  description = "Ingress rules for the network ACL"
}

variable "egress_rules" {
  type = list(object({
    protocol   = string
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
  description = "Egress rules for the network ACL"
}