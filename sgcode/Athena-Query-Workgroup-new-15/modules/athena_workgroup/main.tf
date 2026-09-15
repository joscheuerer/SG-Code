resource "aws_athena_workgroup" "this" {
  name        = var.name
  description = var.description
  state       = var.state

  configuration {
    enforce_workgroup_configuration    = var.enforce_workgroup_configuration
    publish_cloudwatch_metrics_enabled = var.publish_cloudwatch_metrics_enabled
    requester_pays_enabled             = var.requester_pays_enabled

    dynamic "engine_version" {
      for_each = var.selected_engine_version != null ? [var.selected_engine_version] : []
      content {
        selected_engine_version = engine_version.value
      }
    }
  }

  tags = var.tags
}
