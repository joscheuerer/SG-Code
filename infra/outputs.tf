output "role_ids" {
  value       = [for k, v in module.lambda_edge_roles : v.role_id]
  description = "List of IAM role unique IDs"
}

output "role_arns" {
  value       = [for k, v in module.lambda_edge_roles : v.role_arn]
  description = "List of IAM role ARNs"
}