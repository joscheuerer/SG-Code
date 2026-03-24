variable "vpc_id" {
  type        = string
  description = "ID of the VPC to attach the internet gateway to"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the internet gateway"
}