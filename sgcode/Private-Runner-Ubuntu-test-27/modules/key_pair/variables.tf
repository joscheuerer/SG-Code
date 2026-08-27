# Variables for the key pair module

variable "key_name" {
  description = "Name of the key pair."
  type        = string
}

variable "public_key" {
  description = "Public key material. Write-only — ignored after initial creation/import."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the key pair."
  type        = map(string)
  default     = {}
}
