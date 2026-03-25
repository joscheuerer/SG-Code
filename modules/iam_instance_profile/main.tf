resource "aws_iam_instance_profile" "this" {
  name = var.profile_name
  path = var.path
  role = var.role_name
}