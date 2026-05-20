variable "name" {
  description = "Stack name"
  type        = string
}

variable "capabilities" {
  description = "A list of capabilities for the stack"
  type        = list(string)
  default     = []
}

variable "disable_rollback" {
  description = "Set to true to disable rollback of the stack if stack creation failed"
  type        = bool
  default     = false
}

variable "parameters" {
  description = "A map of parameter key-value pairs for the stack"
  type        = map(string)
  default     = {}
}