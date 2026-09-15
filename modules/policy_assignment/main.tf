resource "azurerm_management_group_policy_assignment" "this" {
  name                 = var.name
  display_name         = var.display_name != "" ? var.display_name : null
  policy_definition_id = var.policy_definition_id
  management_group_id  = var.management_group_id
  enforce              = var.enforce
  parameters           = var.parameters != "" ? var.parameters : null
  not_scopes           = length(var.not_scopes) > 0 ? var.not_scopes : null
}
