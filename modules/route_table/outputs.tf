output "route_table_ids" {
  value       = { for k, v in aws_route_table.this : k => v.id }
  description = "Map of route table keys to route table IDs"
}