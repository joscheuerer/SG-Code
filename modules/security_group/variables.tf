variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "description" {
  type        = string
  description = "Description of the security group"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC for the security group"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the security group"
}