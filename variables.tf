variable "region" {
  type        = string
  description = "Azure region"
}

variable "subnets" {
  type = map(object({
    address_prefix = optional(string)
  }))
  description = "Subnets to create"
}