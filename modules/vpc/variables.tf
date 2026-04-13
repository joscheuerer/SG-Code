variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "instance_tenancy" {
  type        = string
  description = "Tenancy option for instances launched into the VPC"
}

variable "enable_dns_support" {
  type        = bool
  description = "Whether DNS support is enabled in the VPC"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the VPC"
  default     = {}
}