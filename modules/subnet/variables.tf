variable "vpc_id" {
  type        = string
  description = "VPC ID to create subnets in"
}

variable "subnets" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
  description = "Subnet configurations"
  default     = {}
}