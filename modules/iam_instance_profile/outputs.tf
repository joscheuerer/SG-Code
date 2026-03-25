output "arn" {
  description = "ARN of the instance profile"
  value       = aws_iam_instance_profile.this.arn
}

output "id" {
  description = "ID of the instance profile"
  value       = aws_iam_instance_profile.this.id
}

output "name" {
  description = "Name of the instance profile"
  value       = aws_iam_instance_profile.this.name
}