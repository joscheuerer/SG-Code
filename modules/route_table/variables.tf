variable "vpc_id" {
  type        = string
  description = "The VPC ID where the route table will be created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the route table"
}

variable "subnet_associations" {
  type = map(object({
    subnet_id = string
  }))
  description = "Map of subnet associations for the route table"
  default     = {}
}