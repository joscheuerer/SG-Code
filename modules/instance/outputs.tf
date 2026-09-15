output "id" {
  description = "The instance ID"
  value       = aws_instance.this.id
}

output "arn" {
  description = "The instance ARN"
  value       = aws_instance.this.arn
}

output "public_ip" {
  description = "The public IP address"
  value       = aws_instance.this.public_ip
}

output "private_ip" {
  description = "The private IP address"
  value       = aws_instance.this.private_ip
}
