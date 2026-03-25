variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "block_public_acls" {
  type        = bool
  description = "Whether to block public ACLs"
}

variable "block_public_policy" {
  type        = bool
  description = "Whether to block public bucket policies"
}

variable "ignore_public_acls" {
  type        = bool
  description = "Whether to ignore public ACLs"
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Whether to restrict public bucket policies"
}

variable "object_ownership" {
  type        = string
  description = "Object ownership control setting"
}

variable "sse_algorithm" {
  type        = string
  description = "Server-side encryption algorithm"
}

variable "bucket_key_enabled" {
  type        = bool
  description = "Whether S3 Bucket Key is enabled"
}