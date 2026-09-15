resource "aws_athena_workgroup" "this" {
  name        = var.name
  description = var.description
  state       = var.state
  tags        = var.tags

  configuration {
    enforce_workgroup_configuration    = var.enforce_workgroup_configuration
    publish_cloudwatch_metrics_enabled = var.publish_cloudwatch_metrics_enabled
    requester_pays_enabled             = var.requester_pays_enabled

    bytes_scanned_cutoff_per_query = var.bytes_scanned_cutoff_per_query

    dynamic "engine_version" {
      for_each = var.selected_engine_version != null ? [var.selected_engine_version] : []
      content {
        selected_engine_version = engine_version.value
      }
    }
  }
}
