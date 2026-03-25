variable "vpc_id" {
  description = "VPC ID where subnet will be created"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Whether to auto-assign public IPs"
  type        = bool
}

variable "assign_ipv6_address_on_creation" {
  description = "Whether to assign IPv6 addresses"
  type        = bool
}

variable "tags" {
  description = "Tags to apply to the subnet"
  type        = map(string)
}