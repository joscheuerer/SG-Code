variable "vpc_id" {
  type        = string
  description = "The VPC ID to associate the subnet with"
}

variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the subnet"
}

variable "availability_zone" {
  type        = string
  description = "AZ for the subnet"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether instances launched into the subnet should be assigned a public IP address"
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  description = "Whether network interfaces created in the subnet should be assigned an IPv6 address"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the subnet"
}