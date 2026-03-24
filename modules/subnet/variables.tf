variable "vpc_id" {
  type        = string
  description = "The VPC ID where the subnet will be created"
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

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the subnet"
}