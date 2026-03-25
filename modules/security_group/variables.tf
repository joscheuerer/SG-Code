variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Security group description"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where security group will be created"
  type        = string
}

variable "rules" {
  description = "Security group rules to create"
  type = map(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = optional(string)
  }))
  default = {}
}