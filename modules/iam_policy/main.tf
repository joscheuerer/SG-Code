resource "aws_iam_policy" "this" {
  name   = var.policy_name
  path   = var.path
  policy = jsonencode(var.policy_document)
}