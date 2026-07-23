variable "vpc_id" {
  type        = string
  description = "VPC ID for the network ACL"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to associate with the network ACL"
}