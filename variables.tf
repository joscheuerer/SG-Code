variable "region" {
  type        = string
  description = "AWS region"
}

variable "iam_instance_profile_arn" {
  type        = string
  description = "IAM instance profile ARN for EC2 instances"
}