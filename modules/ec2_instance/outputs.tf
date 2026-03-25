output "instance_id" {
  value       = aws_instance.this.id
  description = "EC2 instance ID"
}

output "instance_private_ip" {
  value       = aws_instance.this.private_ip
  description = "EC2 instance private IP address"
}

output "volume_id" {
  value       = aws_ebs_volume.this.id
  description = "EBS volume ID"
}