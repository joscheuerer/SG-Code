variable "name" {
  type        = string
  description = "Name of the IAM role"
}

variable "path" {
  type        = string
  description = "Path for the IAM role"
}

variable "assume_role_policy_document" {
  type        = any
  description = "Assume role policy document structure"
}

variable "max_session_duration" {
  type        = number
  description = "Maximum session duration in seconds"
}

variable "inline_policies" {
  type = map(object({
    policy_name     = string
    policy_document = any
  }))
  description = "Map of inline policies to attach to the role"
  default     = {}
}