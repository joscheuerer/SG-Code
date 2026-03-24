variable "cidr_block" {
  type        = string
  description = "CIDR block for VPC"
}

variable "instance_tenancy" {
  type        = string
  description = "Instance tenancy option"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}