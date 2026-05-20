output "name" {
  description = "Name of the IAM instance profile"
  value       = aws_iam_instance_profile.this.name
}

output "arn" {
  description = "ARN of the IAM instance profile"
  value       = aws_iam_instance_profile.this.arn
}