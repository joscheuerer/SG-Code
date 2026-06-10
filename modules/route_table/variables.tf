variable "vpc_id" {
  type = string
}

variable "internet_gateway_id" {
  type    = string
  default = ""
}

variable "routes" {
  type = list(object({
    cidr_block = optional(string, "")
    use_igw    = optional(bool, false)
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
