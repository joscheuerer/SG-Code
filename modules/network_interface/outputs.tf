output "id" {
  description = "ID of the network interface"
  value       = aws_network_interface.this.id
}

output "private_ip" {
  description = "Primary private IP address"
  value       = aws_network_interface.this.private_ip
}

output "mac_address" {
  description = "MAC address of the network interface"
  value       = aws_network_interface.this.mac_address
}