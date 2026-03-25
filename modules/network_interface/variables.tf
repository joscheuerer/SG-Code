variable "subnet_id" {
  description = "Subnet ID where ENI will be created"
  type        = string
}

variable "private_ips" {
  description = "Private IP addresses to assign"
  type        = list(string)
}

variable "security_groups" {
  description = "Security group IDs to attach"
  type        = list(string)
}

variable "source_dest_check" {
  description = "Whether to enable source/destination checking"
  type        = bool
}