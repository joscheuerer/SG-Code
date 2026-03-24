variable "vpc_id" {
  type        = string
  description = "VPC ID to attach internet gateway"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to internet gateway"
}