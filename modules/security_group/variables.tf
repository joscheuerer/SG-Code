variable "vpc_id" {
  type        = string
  description = "VPC ID for security groups"
}

variable "security_groups" {
  type = map(object({
    name        = string
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
    from_port          = number
    to_port            = number
    protocol           = string
    cidr_blocks        = list(string)
    description        = string
  }))
  description = "Security group rules"
  default     = {}
}