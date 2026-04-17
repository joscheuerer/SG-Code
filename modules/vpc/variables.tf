variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "instance_tenancy" {
  type        = string
  description = "Tenancy option for instances launched into the VPC"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the VPC"
}