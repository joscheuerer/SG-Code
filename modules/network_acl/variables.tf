variable "vpc_id" {
  type        = string
  description = "VPC ID for network ACL"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to associate with network ACL"
}

variable "acl_rules" {
  type = map(object({
    rule_number = number
    egress      = bool
    protocol    = string
    rule_action = string
    cidr_block  = string
  }))
  description = "Network ACL rules"
  default     = {}
}