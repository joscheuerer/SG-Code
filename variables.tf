variable "region" {
  description = "AWS region where resources will be managed"
  type        = string
}

variable "iam_role_name" {
  description = "Friendly name of the IAM role"
  type        = string
}

variable "iam_role_path" {
  description = "Path to the IAM role"
  type        = string
}

variable "iam_role_max_session_duration" {
  description = "Maximum session duration in seconds"
  type        = number
}

variable "iam_role_assume_role_policy" {
  description = "JSON policy document granting permission to assume the role"
  type        = string
}

variable "iam_role_managed_policy_arns" {
  description = "Set of managed policy ARNs to attach to the role"
  type        = set(string)
}

variable "iam_role_inline_policies" {
  description = "Map of inline policies to attach to the role"
  type        = map(object({ policy_name = string, policy_document = string }))
}

variable "iam_role_tags" {
  description = "Tags to assign to the IAM role"
  type        = map(string)
}

variable "s3_buckets" {
  description = "Map of S3 bucket configurations"
  type = map(object({
    bucket = string
    tags   = map(string)
  }))
}