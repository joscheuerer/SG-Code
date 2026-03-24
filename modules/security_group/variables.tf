variable "vpc_id" {
  type        = string
  description = "VPC ID for the security groups"
}

variable "security_groups" {
  type = map(object({
    group_name  = string
    description = string
    tags        = map(string)
  }))
  description = "Security group configurations"
  default     = {}
}

variable "security_group_rules" {
  type = map(object({
    security_group_key = string
    type               = string
    protocol           = string
    from_port          = number
    to_port            = number
    cidr_blocks        = list(string)
    description        = string
  }))
  description = "Security group rules to create"
  default     = {}
}