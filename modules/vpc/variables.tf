variable "cidr_block" {
  type        = string
  description = "CIDR block for VPC"
}

variable "instance_tenancy" {
  type        = string
  description = "Tenancy option for instances launched into the VPC"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in the VPC"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support in the VPC"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to VPC"
}