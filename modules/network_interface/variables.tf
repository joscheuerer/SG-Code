variable "subnet_id" {
  type        = string
  description = "Subnet ID to create the ENI in"
}

variable "private_ips" {
  type        = list(string)
  description = "Private IP addresses to assign to the ENI"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security group IDs to assign to the ENI"
}

variable "source_dest_check" {
  type        = bool
  description = "Whether to enable source/destination checking"
}

variable "attached_instance_id" {
  type        = string
  description = "ID of the instance to attach the ENI to"
}

variable "device_index" {
  type        = number
  description = "Device index for the ENI attachment"
}