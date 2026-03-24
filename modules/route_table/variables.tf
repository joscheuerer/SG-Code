variable "vpc_id" {
  type        = string
  description = "VPC ID for route tables"
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
  description = "Routes to create in route tables"
  default     = {}
}

variable "associations" {
  type = map(object({
    route_table_key = string
    subnet_id       = string
  }))
  description = "Route table to subnet associations"
  default     = {}
}