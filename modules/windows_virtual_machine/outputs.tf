output "id" {
  description = "The ID of the Windows virtual machine"
  value       = azurerm_windows_virtual_machine.this.id
}

output "private_ip_addresses" {
  description = "Private IP addresses"
  value       = azurerm_windows_virtual_machine.this.private_ip_addresses
}
