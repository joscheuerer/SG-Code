output "launch_template_ids" {
  description = "Map of launch template IDs"
  value       = { for k, v in aws_launch_template.this : k => v.id }
}

output "launch_template_arns" {
  description = "Map of launch template ARNs"
  value       = { for k, v in aws_launch_template.this : k => v.arn }
}