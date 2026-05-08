variable "name" {
  type        = string
  description = "Friendly name of the IAM role"
}

variable "assume_role_policy" {
  type        = string
  description = "Policy document granting permission to assume the role (JSON string)"
}

variable "description" {
  type        = string
  description = "Description of the IAM role"
}

variable "path" {
  type        = string
  description = "Path to the IAM role"
}

variable "max_session_duration" {
  type        = number
  description = "Maximum session duration in seconds"
}

variable "attached_policy_arns" {
  type        = set(string)
  description = "Set of managed policy ARNs to attach to the role"
  default     = []
}