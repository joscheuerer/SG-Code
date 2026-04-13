variable "vpc_id" {
  type        = string
  description = "The ID of the VPC in which to create the subnet"
}

variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the subnet"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone for the subnet"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether instances launched in this subnet receive a public IP"
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  description = "Whether IPv6 addresses are assigned on instance creation"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the subnet"
  default     = {}
}