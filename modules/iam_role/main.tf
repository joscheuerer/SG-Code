resource "aws_iam_role" "this" {
  assume_role_policy   = var.assume_role_policy
  managed_policy_arns  = var.managed_policy_arns
  max_session_duration = var.max_session_duration
  name                 = var.name
  path                 = var.path
  tags                 = var.tags

  dynamic "inline_policy" {
    for_each = var.inline_policies
    content {
      name   = inline_policy.value.policy_name
      policy = inline_policy.value.policy_document
    }
  }
}