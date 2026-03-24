resource "aws_launch_template" "this" {
  for_each = var.launch_templates

  default_version = each.value.default_version
  latest_version  = each.value.latest_version
  name            = each.value.name
}