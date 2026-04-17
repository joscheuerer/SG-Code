output "network_interface_id" {
  description = "The ID of the network interface"
  value       = aws_network_interface.this.id
}