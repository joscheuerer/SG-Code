output "volume_id" {
  description = "EBS volume ID"
  value       = aws_ebs_volume.this.id
}