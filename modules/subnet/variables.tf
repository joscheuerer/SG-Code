variable "vpc_id" {
  type        = string
  description = "VPC ID to associate the subnet with"
}

variable "cidr_block" {
  type        = string
  description = "IPv4 CIDR block for the subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the subnet"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether to assign a public IP to instances launched in this subnet"
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  description = "Whether to assign IPv6 addresses on creation"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the subnet"
}