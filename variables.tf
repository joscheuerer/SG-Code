variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "inline_policies" {
  type = map(object({
    policy_name     = string
    policy_document = any
  }))
  description = "Inline policies to attach to the role"
  default     = {}
}