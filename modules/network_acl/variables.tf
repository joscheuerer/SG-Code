variable "vpc_id" {
  type        = string
  description = "VPC ID for the network ACL"
}

variable "network_acl_rules" {
  type = map(object({
    rule_number = number
    egress      = bool
    protocol    = string
    rule_action = string
    cidr_block  = string
  }))
  description = "Network ACL rule configurations"
  default     = {}
}