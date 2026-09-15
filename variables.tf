variable "policy_assignments" {
  description = "Map of azurerm_policy_assignment instances"
  type = map(object({
    name                 = string
    display_name         = optional(string, "")
    policy_definition_id = string
    management_group_id  = string
    enforce              = optional(bool, true)
    parameters           = optional(string, "")
    not_scopes           = optional(list(string), [])
  }))
  default = {}
}

variable "role_assignments" {
  description = "Map of azurerm_role_assignment instances"
  type = map(object({
    name               = string
    scope              = string
    role_definition_id = string
    principal_id       = string
  }))
  default = {}
}
