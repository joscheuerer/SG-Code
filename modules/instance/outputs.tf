output "instance_id" {
  description = "Instance ID"
  value       = aws_instance.this.id
}

output "primary_network_interface_id" {
  description = "Primary network interface ID"
  value       = aws_instance.this.primary_network_interface_id
}