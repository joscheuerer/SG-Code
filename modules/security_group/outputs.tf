output "security_group_ids" {
  value       = { for k, v in aws_security_group.this : k => v.id }
  description = "Map of security group keys to security group IDs"
}