variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
}

variable "instance_profile_path" {
  description = "Path to the IAM instance profile"
  type        = string
}

variable "instance_profile_role" {
  description = "Name of the IAM role to associate with the instance profile"
  type        = string
}

variable "key_pair_key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "key_pair_public_key" {
  description = "Public key material for the EC2 key pair"
  type        = string
  sensitive   = true
}