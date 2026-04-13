variable "name" {
  type        = string
  description = "The name of the security group"
}

variable "description" {
  type        = string
  description = "Description of the security group"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC in which to create the security group"
}