variable "key_name" {
  description = "The name for the key pair"
  type        = string
}

variable "public_key" {
  description = "The public key material"
  type        = string
  sensitive   = true
}