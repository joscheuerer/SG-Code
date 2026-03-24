variable "vpc_id" {
  type        = string
  description = "VPC ID to create subnet in"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for subnet"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Auto-assign public IP on launch"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}