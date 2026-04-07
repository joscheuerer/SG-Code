variable "vpc_id" {
  type        = string
  description = "VPC ID where the subnet will be created"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the subnet"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether to auto-assign public IPs to instances"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the subnet"
}