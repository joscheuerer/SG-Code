output "volume_id" {
  value       = aws_ebs_volume.this.id
  description = "EBS volume ID"
}