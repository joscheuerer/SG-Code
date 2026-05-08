variable "bucket" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the bucket"
  default     = {}
}