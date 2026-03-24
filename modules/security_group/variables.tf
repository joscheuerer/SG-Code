variable "name" {
  type        = string
  description = "Security group name"
}

variable "description" {
  type        = string
  description = "Security group description"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for security group"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "ingress_rules" {
  type = map(object({
    protocol  = string
    from_port = number
    to_port   = number
    self      = bool
  }))
  description = "Ingress rules to create"
  default     = {}
}

variable "egress_rules" {
  type = map(object({
    protocol    = string
    from_port   = number
    to_port     = number
    cidr_blocks = list(string)
  }))
  description = "Egress rules to create"
  default     = {}
}