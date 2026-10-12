variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "workflow_schema" {
  type    = string
  default = "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#"
}

variable "workflow_version" {
  type    = string
  default = "1.0.0.0"
}

variable "enabled" {
  type    = bool
  default = true
}

variable "parameters" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "sg_api_key" {
  type      = string
  sensitive = true
  default   = ""
}
