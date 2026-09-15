module "athena_workgroup" {
  source   = "./modules/athena_workgroup"
  for_each = var.athena_workgroups

  name                               = each.value.name
  description                        = each.value.description
  state                              = each.value.state
  enforce_workgroup_configuration    = each.value.enforce_workgroup_configuration
  publish_cloudwatch_metrics_enabled = each.value.publish_cloudwatch_metrics_enabled
  requester_pays_enabled             = each.value.requester_pays_enabled
  bytes_scanned_cutoff_per_query     = each.value.bytes_scanned_cutoff_per_query
  selected_engine_version            = each.value.selected_engine_version
  tags                               = each.value.tags
}
