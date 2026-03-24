variable "subnet_id" {
  type        = string
  description = "Subnet ID for network interface"
}

variable "private_ips" {
  type        = list(string)
  description = "Private IP addresses"
}

variable "security_groups" {
  type        = list(string)
  description = "Security group IDs"
}

variable "source_dest_check" {
  type        = bool
  description = "Enable source/destination checking"
}

variable "description" {
  type        = string
  description = "Network interface description"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "instance_id" {
  type        = string
  description = "Instance ID to attach to"
}

variable "device_index" {
  type        = number
  description = "Device index for attachment"
}