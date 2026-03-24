variable "vpc_id" {
  type        = string
  description = "ID of the VPC to create subnets in"
}

variable "subnets" {
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
  description = "Map of subnets to create"
  default     = {}
}