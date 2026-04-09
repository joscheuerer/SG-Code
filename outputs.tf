output "virtual_network_id" {
  description = "Virtual network ID"
  value       = module.virtual_network.virtual_network_id
}

output "virtual_network_name" {
  description = "Virtual network name"
  value       = module.virtual_network.virtual_network_name
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value       = module.virtual_network.subnet_ids
}