variable "subnet_id" {
  type        = string
  description = "Subnet ID for the ENI"
}

variable "private_ips" {
  type        = list(string)
  description = "Private IP addresses to assign to the ENI"
}

variable "security_groups" {
  type        = list(string)
  description = "Security group IDs to assign to the ENI"
}

variable "source_dest_check" {
  type        = bool
  description = "Whether to enable source/destination check"
}