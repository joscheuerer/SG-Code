variable "key_name" {
  type = string
}

variable "public_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
