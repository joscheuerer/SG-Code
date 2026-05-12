variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "description" {
  type        = string
  description = "Description of the security group"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID for the security group"
}

variable "ingress" {
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    security_groups  = optional(list(string))
    cidr_blocks      = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    prefix_list_ids  = optional(list(string))
    description      = optional(string)
    self             = optional(bool)
  }))
  description = "Ingress rules for the security group"
  default     = []
}

variable "egress" {
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    prefix_list_ids  = optional(list(string))
    security_groups  = optional(list(string))
    description      = optional(string)
    self             = optional(bool)
  }))
  description = "Egress rules for the security group"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the security group"
}