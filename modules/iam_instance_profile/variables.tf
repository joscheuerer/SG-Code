variable "name" {
  description = "Name of the IAM instance profile"
  type        = string
}

variable "path" {
  description = "Path to the instance profile"
  type        = string
}

variable "role" {
  description = "Name of the IAM role to associate with the instance profile"
  type        = string
}