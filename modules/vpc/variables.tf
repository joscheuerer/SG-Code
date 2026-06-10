variable "cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "tags" {
  type    = map(string)
  default = {}
}
