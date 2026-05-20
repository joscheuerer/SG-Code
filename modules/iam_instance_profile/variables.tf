variable "name" {
  type        = string
  description = "Name of the IAM instance profile"
}

variable "path" {
  type        = string
  description = "Path for the IAM instance profile"
}

variable "role" {
  type        = string
  description = "Name of the IAM role to associate with the instance profile"
}