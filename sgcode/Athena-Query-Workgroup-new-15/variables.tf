variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "athena_workgroups" {
  type = map(object({
    name                               = string
    description                        = optional(string, "")
    state                              = optional(string, "ENABLED")
    enforce_workgroup_configuration    = optional(bool, true)
    publish_cloudwatch_metrics_enabled = optional(bool, true)
    requester_pays_enabled             = optional(bool, false)
    bytes_scanned_cutoff_per_query     = optional(number, null)
    selected_engine_version            = optional(string, null)
    tags                               = optional(map(string), {})
  }))
  default = {}
}
