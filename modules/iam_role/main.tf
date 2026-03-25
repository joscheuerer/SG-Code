resource "aws_iam_role" "this" {
  assume_role_policy   = jsonencode(var.assume_role_policy_document)
  max_session_duration = var.max_session_duration
  name                 = var.role_name
  path                 = var.path
}

resource "aws_iam_role_policy" "this" {
  for_each = var.inline_policies

  name   = each.value.policy_name
  policy = jsonencode(each.value.policy_document)
  role   = aws_iam_role.this.name
}