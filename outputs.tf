output "role_arn" {
  description = "ARN of the Lambda@Edge IAM role"
  value       = module.lambda_edge_role.role_arn
}

output "role_name" {
  description = "Name of the Lambda@Edge IAM role"
  value       = module.lambda_edge_role.role_name
}