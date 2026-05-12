variable "default_network_acl_id" {
  type        = string
  description = "The ID of the default network ACL to manage"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID for the network ACL"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to associate with the network ACL"
  default     = []
}

variable "egress" {
  type = list(object({
    rule_no         = number
    action          = string
    protocol        = string
    cidr_block      = optional(string)
    ipv6_cidr_block = optional(string)
    from_port       = number
    to_port         = number
    icmp_type       = optional(number)
    icmp_code       = optional(number)
  }))
  description = "Egress rules for the network ACL"
  default     = []
}

variable "ingress" {
  type = list(object({
    rule_no         = number
    action          = string
    protocol        = string
    cidr_block      = optional(string)
    ipv6_cidr_block = optional(string)
    from_port       = number
    to_port         = number
    icmp_type       = optional(number)
    icmp_code       = optional(number)
  }))
  description = "Ingress rules for the network ACL"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the network ACL"
}