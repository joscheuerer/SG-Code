output "instance_ids" {
  description = "Map of instance keys to instance IDs"
  value       = { for k, v in aws_instance.this : k => v.id }
}

output "private_ips" {
  description = "Map of instance keys to private IP addresses"
  value       = { for k, v in aws_instance.this : k => v.private_ip }
}

output "public_ips" {
  description = "Map of instance keys to public IP addresses"
  value       = { for k, v in aws_instance.this : k => v.public_ip }
}