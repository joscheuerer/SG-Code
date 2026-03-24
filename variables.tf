variable "region" {
  type        = string
  description = "AWS region"
}

variable "subnets" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
  description = "Subnet configurations"
}

variable "route_tables" {
  type = map(object({
    tags = map(string)
  }))
  description = "Route table configurations"
}

variable "routes" {
  type = map(object({
    route_table_key        = string
    destination_cidr_block = string
    gateway_id             = string
  }))
  description = "Routes to create in route tables"
}

variable "route_table_associations" {
  type = map(object({
    route_table_key = string
    subnet_id       = string
  }))
  description = "Route table to subnet associations"
}

variable "security_groups" {
  type = map(object({
    group_name  = string
    description = string
    tags        = map(string)
  }))
  description = "Security group configurations"
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
}