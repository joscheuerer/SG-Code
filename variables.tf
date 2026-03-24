variable "region" {
  description = "AWS region"
  type        = string
}

variable "launch_templates" {
  description = "Launch templates to create"
  type        = map(object({ name = string, default_version = number, latest_version = number }))
}