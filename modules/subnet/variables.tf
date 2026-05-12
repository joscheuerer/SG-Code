variable "vpc_id" {
  type        = string
  description = "The VPC ID to create the subnet in"
}

variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the subnet"
}

variable "availability_zone" {
  type        = string
  description = "The AZ for the subnet"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether to assign a public IP on launch"
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  description = "Whether to assign an IPv6 address on creation"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the subnet"
}