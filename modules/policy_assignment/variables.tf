variable "name" {
  type = string
}

variable "display_name" {
  type    = string
  default = ""
}

variable "policy_definition_id" {
  type = string
}

variable "management_group_id" {
  type = string
}

variable "enforce" {
  type    = bool
  default = true
}

variable "parameters" {
  type    = string
  default = ""
}

variable "not_scopes" {
  type    = list(string)
  default = []
}
