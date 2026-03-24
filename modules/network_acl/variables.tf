variable "vpc_id" {
  type        = string
  description = "ID of the VPC for the network ACL"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to associate with the network ACL"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the network ACL"
}

variable "acl_rules" {
  type = map(object({
    rule_number     = number
    egress          = bool
    protocol        = string
    rule_action     = string
    cidr_block      = optional(string)
    ipv6_cidr_block = optional(string)
  }))
  description = "Map of network ACL rules to create"
  default     = {}
}