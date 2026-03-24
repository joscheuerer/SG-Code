output "subnet_ids" {
  value       = { for k, v in aws_subnet.this : k => v.id }
  description = "Map of subnet keys to subnet IDs"
}