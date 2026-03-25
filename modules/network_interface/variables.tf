variable "subnet_id" {
  description = "Subnet ID for the network interface"
  type        = string
}

variable "private_ips" {
  description = "Private IP addresses"
  type        = list(string)
}

variable "description" {
  description = "Description of the network interface"
  type        = string
}