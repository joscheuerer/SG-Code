resource "azurerm_logic_app_workflow" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  workflow_schema     = var.workflow_schema
  workflow_version    = var.workflow_version
  enabled             = var.enabled
  parameters          = var.parameters
  tags                = var.tags

  workflow_parameters = {
    "$connections" = jsonencode({
      defaultValue = {}
      type         = "Object"
    })
  }

  lifecycle {
    ignore_changes = [workflow_parameters, parameters]
  }
}
