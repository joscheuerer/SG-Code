variable "name" {
  type        = string
  description = "Name of the IAM role"
}

variable "path" {
  type        = string
  description = "Path for the IAM role"
}

variable "max_session_duration" {
  type        = number
  description = "Maximum session duration in seconds"
}

variable "assume_role_policy_document" {
  type = object({
    Version = string
    Statement = list(object({
      Effect = string
      Principal = object({
        Service = list(string)
      })
      Action = string
    }))
  })
  description = "Trust policy document for role assumption"
}

variable "inline_policies" {
  type = map(object({
    policy_name = string
    policy_document = object({
      Version = string
      Statement = list(object({
        Action   = list(string)
        Effect   = string
        Resource = string
      }))
    })
  }))
  description = "Inline policies to attach to the role"
  default     = {}
}