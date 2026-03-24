variable "vpc_id" {
  type        = string
  description = "ID of the VPC for route tables"
}

variable "route_tables" {
  type = map(object({
    tags = map(string)
  }))
  description = "Map of route tables to create"
  default     = {}
}

variable "routes" {
  type = map(object({
    route_table_key        = string
    destination_cidr_block = string
    gateway_id             = string
  }))
  description = "Map of routes to create (excluding local routes)"
  default     = {}
}

variable "route_table_associations" {
  type = map(object({
    route_table_key = string
    subnet_id       = string
  }))
  description = "Map of route table to subnet associations"
  default     = {}
}