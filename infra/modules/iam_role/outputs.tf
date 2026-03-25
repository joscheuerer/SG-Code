output "role_id" {
  value       = aws_iam_role.this.unique_id
  description = "Unique ID of the IAM role"
}

output "role_arn" {
  value       = aws_iam_role.this.arn
  description = "ARN of the IAM role"
}

output "role_name" {
  value       = aws_iam_role.this.name
  description = "Name of the IAM role"
}