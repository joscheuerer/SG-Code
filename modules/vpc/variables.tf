variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "instance_tenancy" {
  type        = string
  description = "Instance tenancy option for the VPC"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the VPC"
}