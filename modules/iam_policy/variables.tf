variable "policy_name" {
  type        = string
  description = "Name of the IAM policy"
}

variable "path" {
  type        = string
  description = "Path for the IAM policy"
}

variable "policy_document" {
  type = object({
    Version = string
    Statement = list(object({
      Effect    = string
      Action    = list(string)
      Resource  = any
      Condition = optional(map(map(any)))
    }))
  })
  description = "IAM policy document structure"
}