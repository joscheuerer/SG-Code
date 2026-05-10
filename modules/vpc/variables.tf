variable "cidr_block" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "Tenancy option for instances launched into the VPC"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the VPC"
  type        = map(string)
}