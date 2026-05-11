output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.instance.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = module.instance.arn
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.instance.private_ip
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.instance.public_ip
}

output "iam_instance_profile_arn" {
  description = "ARN of the IAM instance profile"
  value       = module.iam_instance_profile.arn
}

output "key_pair_key_name" {
  description = "Name of the EC2 key pair"
  value       = module.key_pair.key_name
}