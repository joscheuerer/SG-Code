output "volume_ids" {
  description = "Map of volume keys to volume IDs"
  value       = module.ebs_volumes.volume_ids
}

output "volume_arns" {
  description = "Map of volume keys to volume ARNs"
  value       = module.ebs_volumes.volume_arns
}