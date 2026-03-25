output "instance_ids" {
  description = "Map of instance keys to instance IDs"
  value       = { for k, v in aws_instance.this : k => v.id }
}

output "instance_private_ips" {
  description = "Map of instance keys to private IP addresses"
  value       = { for k, v in aws_instance.this : k => v.private_ip }
}

output "instance_public_ips" {
  description = "Map of instance keys to public IP addresses"
  value       = { for k, v in aws_instance.this : k => v.public_ip }
}

output "volume_ids" {
  description = "Map of volume keys to volume IDs"
  value       = { for k, v in aws_ebs_volume.this : k => v.id }
}