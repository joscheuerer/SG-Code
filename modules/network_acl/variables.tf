variable "vpc_id" {
  type        = string
  description = "VPC ID for the network ACL"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to associate with the network ACL"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the network ACL"
}

variable "acl_rules" {
  type = map(object({
    rule_number = number
    egress      = bool
    protocol    = string
    rule_action = string
    cidr_block  = string
  }))
  description = "Network ACL rules to create"
  default     = {}
}