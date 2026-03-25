output "network_interface_id" {
  description = "ID of the network interface"
  value       = aws_network_interface.this.id
}

output "mac_address" {
  description = "MAC address of the network interface"
  value       = aws_network_interface.this.mac_address
}