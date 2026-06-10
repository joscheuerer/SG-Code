variable "vpc" {
  type = object({
    cidr_block       = string
    instance_tenancy = optional(string, "default")
    tags             = optional(map(string), {})
  })
}

variable "subnets" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = optional(bool, false)
    tags                    = optional(map(string), {})
  }))
  default = {}
}

variable "internet_gateway" {
  type = object({
    tags = optional(map(string), {})
  })
  default = {}
}

variable "route_tables" {
  type = map(object({
    routes = optional(list(object({
      cidr_block = optional(string, "")
      use_igw    = optional(bool, false)
    })), [])
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    ingress = optional(list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      description = optional(string, "")
      self        = optional(bool, false)
    })), [])
    egress = optional(list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      description = optional(string, "")
      self        = optional(bool, false)
    })), [])
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "network_acls" {
  type = map(object({
    default_network_acl_id = string
    subnet_keys            = optional(list(string), [])
    ingress = optional(list(object({
      rule_no    = number
      action     = string
      protocol   = string
      cidr_block = string
      from_port  = optional(number, 0)
      to_port    = optional(number, 0)
    })), [])
    egress = optional(list(object({
      rule_no    = number
      action     = string
      protocol   = string
      cidr_block = string
      from_port  = optional(number, 0)
      to_port    = optional(number, 0)
    })), [])
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "key_pairs" {
  type = map(object({
    key_name   = string
    public_key = optional(string, "")
    tags       = optional(map(string), {})
  }))
  default = {}
}
