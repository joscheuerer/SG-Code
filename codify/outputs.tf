output "instance_ids" {
  description = "Map of instance keys to instance IDs"
  value       = module.instances.instance_ids
}

output "private_ips" {
  description = "Map of instance keys to private IP addresses"
  value       = module.instances.private_ips
}

output "public_ips" {
  description = "Map of instance keys to public IP addresses"
  value       = module.instances.public_ips
}