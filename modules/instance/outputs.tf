output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "network_interface_id" {
  description = "The ID of the network interface"
  value       = aws_network_interface.this.id
}