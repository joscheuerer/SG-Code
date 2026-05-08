output "instance_profile_arn" {
  description = "ARN of the IAM instance profile"
  value       = module.iam_instance_profile.arn
}

output "key_pair_key_name" {
  description = "Name of the EC2 key pair"
  value       = module.key_pair.key_name
}

output "network_interface_id" {
  description = "ID of the primary network interface"
  value       = module.network_interface.id
}