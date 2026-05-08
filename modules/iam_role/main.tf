resource "aws_iam_role" "this" {
  name                 = var.name
  assume_role_policy   = var.assume_role_policy
  description          = var.description
  max_session_duration = var.max_session_duration
  path                 = var.path
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = var.attached_policy_arns
  role       = aws_iam_role.this.name
  policy_arn = each.value
}