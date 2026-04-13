output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value       = aws_instance.this.primary_network_interface_id
}