variable "subnet_id" {
  description = "Subnet ID for the network interface"
  type        = string
}

variable "private_ips" {
  description = "List of private IPs to assign to the ENI"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs to assign to the ENI"
  type        = list(string)
}

variable "source_dest_check" {
  description = "Whether to enable source/destination checking"
  type        = bool
}