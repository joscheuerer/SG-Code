output "id" {
  description = "The ID of the Network Interface"
  value       = azurerm_network_interface.this.id
}

output "mac_address" {
  description = "The MAC address of the Network Interface"
  value       = azurerm_network_interface.this.mac_address
}

output "private_ip_address" {
  description = "The first private IP address of the Network Interface"
  value       = azurerm_network_interface.this.private_ip_address
}