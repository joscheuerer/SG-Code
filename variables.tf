variable "region" {
  type        = string
  description = "AWS region"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "vpc_instance_tenancy" {
  type        = string
  description = "Tenancy option for instances launched into the VPC"
}

variable "vpc_tags" {
  type        = map(string)
  description = "Tags to assign to the VPC"
}

variable "subnets" {
  type = map(object({
    cidr_block                      = string
    availability_zone               = string
    map_public_ip_on_launch         = bool
    assign_ipv6_address_on_creation = bool
    tags                            = map(string)
  }))
  description = "Map of subnet configurations"
}

variable "internet_gateway_tags" {
  type        = map(string)
  description = "Tags to assign to the internet gateway"
}

variable "route_tables" {
  type = map(object({
    routes = list(object({
      cidr_block                 = string
      gateway_id                 = optional(string)
      nat_gateway_id             = optional(string)
      ipv6_cidr_block            = optional(string)
      destination_prefix_list_id = optional(string)
      carrier_gateway_id         = optional(string)
      core_network_arn           = optional(string)
      egress_only_gateway_id     = optional(string)
      local_gateway_id           = optional(string)
      network_interface_id       = optional(string)
      transit_gateway_id         = optional(string)
      vpc_endpoint_id            = optional(string)
      vpc_peering_connection_id  = optional(string)
    }))
    tags = map(string)
  }))
  description = "Map of route table configurations"
}

variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    ingress = list(object({
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
    egress = list(object({
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
    tags = map(string)
  }))
  description = "Map of security group configurations"
}

variable "network_acl_egress" {
  type = list(object({
    rule_no         = number
    action          = string
    protocol        = string
    cidr_block      = optional(string)
    ipv6_cidr_block = optional(string)
    from_port       = number
    to_port         = number
    icmp_type       = optional(number)
    icmp_code       = optional(number)
  }))
  description = "Egress rules for the network ACL"
}

variable "network_acl_ingress" {
  type = list(object({
    rule_no         = number
    action          = string
    protocol        = string
    cidr_block      = optional(string)
    ipv6_cidr_block = optional(string)
    from_port       = number
    to_port         = number
    icmp_type       = optional(number)
    icmp_code       = optional(number)
  }))
  description = "Ingress rules for the network ACL"
}

variable "network_acl_tags" {
  type        = map(string)
  description = "Tags to assign to the network ACL"
}