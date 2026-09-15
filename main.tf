module "policy_assignment" {
  source   = "./modules/policy_assignment"
  for_each = var.policy_assignments

  name                 = each.value.name
  display_name         = each.value.display_name
  policy_definition_id = each.value.policy_definition_id
  management_group_id  = each.value.management_group_id
  enforce              = each.value.enforce
  parameters           = each.value.parameters
  not_scopes           = each.value.not_scopes
}

module "role_assignment" {
  source   = "./modules/role_assignment"
  for_each = var.role_assignments

  name               = each.value.name
  scope              = each.value.scope
  role_definition_id = each.value.role_definition_id
  principal_id       = each.value.principal_id
}
