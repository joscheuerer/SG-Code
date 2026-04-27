variable "assume_role_policy" {
  description = "JSON policy document granting permission to assume the role"
  type        = string
}

variable "inline_policies" {
  description = "Map of inline policies to attach to the role"
  type        = map(object({ policy_name = string, policy_document = string }))
  default     = {}
}

variable "managed_policy_arns" {
  description = "Set of managed policy ARNs to attach to the role"
  type        = set(string)
  default     = []
}

variable "max_session_duration" {
  description = "Maximum session duration in seconds"
  type        = number
}

variable "name" {
  description = "Friendly name of the IAM role"
  type        = string
}

variable "path" {
  description = "Path to the IAM role"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the IAM role"
  type        = map(string)
  default     = {}
}