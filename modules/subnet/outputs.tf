output "subnet_id" {
  value       = aws_subnet.this.id
  description = "The ID of the subnet"
}

output "availability_zone" {
  value       = aws_subnet.this.availability_zone
  description = "The availability zone of the subnet"
}