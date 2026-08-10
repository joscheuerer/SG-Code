variable "region" {
  type        = string
  description = "AWS region"
}

variable "roles" {
  type        = map(string)
  description = "Map of role keys to role names"
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
  type = map(map(object({
    policy_name = string
    policy_document = object({
      Version = string
      Statement = list(object({
        Action   = list(string)
        Effect   = string
        Resource = string
      }))
    })
  })))
  description = "Inline policies to attach to roles"
}