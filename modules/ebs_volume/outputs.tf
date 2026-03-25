output "volume_ids" {
  description = "Map of volume keys to volume IDs"
  value       = { for k, v in aws_ebs_volume.this : k => v.id }
}

output "volume_arns" {
  description = "Map of volume keys to volume ARNs"
  value       = { for k, v in aws_ebs_volume.this : k => v.arn }
}