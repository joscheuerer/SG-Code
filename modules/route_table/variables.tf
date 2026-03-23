variable "vpc_id" {
  type        = string
  description = "VPC ID for the route tables"
}

variable "route_tables" {
  type = map(object({
    tags = map(string)
  }))
  description = "Route table configurations"
  default     = {}
}

variable "routes" {
  type = map(object({
    route_table_key        = string
    destination_cidr_block = string
    gateway_id             = string
  }))
  description = "Route configurations for route tables"
  default     = {}
}

variable "route_table_associations" {
  type = map(object({
    route_table_key = string
    subnet_id       = string
  }))
  description = "Route table to subnet associations"
  default     = {}
}