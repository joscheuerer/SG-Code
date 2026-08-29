variable "internet_gateways" {
  description = "Map of Internet Gateway configurations"
  type = map(object({
    vpc_id = string
    tags   = optional(map(string), {})
  }))
  default = {}
}
