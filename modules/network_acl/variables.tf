variable "default_network_acl_id" {
  type = string
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "ingress" {
  type = list(object({
    rule_no    = number
    action     = string
    protocol   = string
    cidr_block = string
    from_port  = optional(number, 0)
    to_port    = optional(number, 0)
  }))
  default = []
}

variable "egress" {
  type = list(object({
    rule_no    = number
    action     = string
    protocol   = string
    cidr_block = string
    from_port  = optional(number, 0)
    to_port    = optional(number, 0)
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
