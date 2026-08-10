module "lambda_edge_roles" {
  for_each = var.roles

  source = "./modules/iam_role"

  name                         = each.value
  path                         = "/"
  max_session_duration         = 3600
  assume_role_policy_document  = var.assume_role_policy_document
  inline_policies              = lookup(var.inline_policies, each.key, {})
}