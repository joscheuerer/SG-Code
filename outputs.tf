output "network_interface_id" {
  description = "The ID of the Network Interface"
  value       = module.network_interface.id
}

output "network_interface_mac_address" {
  description = "The MAC address of the Network Interface"
  value       = module.network_interface.mac_address
}

output "network_interface_private_ip_address" {
  description = "The first private IP address of the Network Interface"
  value       = module.network_interface.private_ip_address
}