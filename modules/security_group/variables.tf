variable "group_name" {
  type        = string
  description = "Name of the security group"
}

variable "description" {
  type        = string
  description = "Description of the security group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the security group will be created"
}

variable "ingress_rules" {
  type = map(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_ipv4   = string
  }))
  description = "Ingress rules to create"
  default     = {}
}

variable "egress_rules" {
  type = map(object({
    ip_protocol = string
    cidr_ipv4   = string
  }))
  description = "Egress rules to create"
  default     = {}
}