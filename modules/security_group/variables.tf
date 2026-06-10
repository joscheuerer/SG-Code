variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), [])
    description = optional(string, "")
    self        = optional(bool, false)
  }))
  default = []
}

variable "egress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), [])
    description = optional(string, "")
    self        = optional(bool, false)
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
