output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = module.storage_backend.bucket_id
}

output "volume_id" {
  description = "ID of the EBS volume"
  value       = module.ebs_volume.volume_id
}

output "network_interface_id" {
  description = "ID of the network interface"
  value       = module.platform_api_eni.network_interface_id
}