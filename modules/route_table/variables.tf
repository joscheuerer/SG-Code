variable "vpc_id" {
  type        = string
  description = "The VPC ID for the route table"
}

variable "routes" {
  type = list(object({
    cidr_block                 = string
    gateway_id                 = optional(string)
    nat_gateway_id             = optional(string)
    ipv6_cidr_block            = optional(string)
    destination_prefix_list_id = optional(string)
    carrier_gateway_id         = optional(string)
    core_network_arn           = optional(string)
    egress_only_gateway_id     = optional(string)
    local_gateway_id           = optional(string)
    network_interface_id       = optional(string)
    transit_gateway_id         = optional(string)
    vpc_endpoint_id            = optional(string)
    vpc_peering_connection_id  = optional(string)
  }))
  description = "List of route objects for the route table"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the route table"
}