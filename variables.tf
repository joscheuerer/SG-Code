variable "region" {
  description = "AWS region"
  type        = string
}

variable "clara_sg_privaterunner_public_key" {
  description = "Public key material for clara-sg-privaterunner key pair"
  type        = string
  sensitive   = true
}

variable "sg_runner_role_name" {
  description = "IAM role name for SG_RUNNER instance profile"
  type        = string
}

variable "taher_private_runner_key_name" {
  description = "Key pair name for taher-private-runner"
  type        = string
}

variable "packer_key_name" {
  description = "Key pair name for packer"
  type        = string
}

variable "nonprod_euc1_key_name" {
  description = "Key pair name for nonprod-euc1"
  type        = string
}

variable "subnet_072669658da496c4a_id" {
  description = "Subnet ID for vpc-0119b9388f2104572"
  type        = string
}

variable "sg_0d5bf7aeaa53bfb92_id" {
  description = "Security group ID for private-runner"
  type        = string
}

variable "sg_04211bd5ce13e32c0_id" {
  description = "Security group ID for packer"
  type        = string
}

variable "sg_064cbb231ba1bca24_id" {
  description = "Security group ID for default"
  type        = string
}

variable "amazonec2containerserviceforec2role_arn" {
  description = "ARN for AmazonEC2ContainerServiceforEC2Role instance profile"
  type        = string
}

variable "vol_0f5a54343d85c2ca9_id" {
  description = "Volume ID for additional EBS volume"
  type        = string
}

variable "i_0073fcf5e556169e8_id" {
  description = "Instance ID for SG_RUNNER instance"
  type        = string
}