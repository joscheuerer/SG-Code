output "policy_arn" {
  value       = aws_iam_policy.this.arn
  description = "ARN of the IAM policy"
}

output "policy_id" {
  value       = aws_iam_policy.this.policy_id
  description = "ID of the IAM policy"
}