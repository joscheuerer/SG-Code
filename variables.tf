variable "region" {
  type        = string
  description = "AWS region"
}

variable "inline_policies" {
  type = map(object({
    policy_name     = string
    policy_document = optional(any, {})
  }))
  description = "Inline policies to attach to the role"
}