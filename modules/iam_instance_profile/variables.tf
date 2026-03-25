variable "profile_name" {
  description = "Name of the instance profile"
  type        = string
}

variable "path" {
  description = "Path for the instance profile"
  type        = string
}

variable "role_name" {
  description = "Name of the IAM role to attach"
  type        = string
}