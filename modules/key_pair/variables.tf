variable "key_name" {
  description = "Name of the key pair"
  type        = string
}

variable "public_key" {
  description = "The public key material"
  type        = string
  sensitive   = true
}