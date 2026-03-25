output "role_id" {
  description = "ID of the Lambda@Edge IAM role"
  value       = module.lambda_edge_role.role_id
}

output "role_arn" {
  description = "ARN of the Lambda@Edge IAM role"
  value       = module.lambda_edge_role.role_arn
}