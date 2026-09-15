resource "azurerm_role_assignment" "this" {
  name               = var.name
  scope              = var.scope
  role_definition_id = var.role_definition_id
  principal_id       = var.principal_id
}
