variable "vpc_id" {
  description = "The VPC ID to associate the subnet with"
  type        = string
}

variable "cidr_block" {
  description = "The IPv4 CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "AZ for the subnet"
  type        = string
}

variable "assign_ipv6_address_on_creation" {
  description = "Whether to assign IPv6 address on creation"
  type        = bool
}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IP on launch"
  type        = bool
}

variable "tags" {
  description = "Tags to assign to the subnet"
  type        = map(string)
}