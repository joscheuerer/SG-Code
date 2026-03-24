output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "subnet_id" {
  value       = module.subnet.subnet_id
  description = "Subnet ID"
}

output "security_group_id" {
  value       = module.security_group.security_group_id
  description = "Security group ID"
}

output "instance_id" {
  value       = module.instance.instance_id
  description = "EC2 instance ID"
}

output "instance_public_ip" {
  value       = module.instance.public_ip
  description = "Public IP address of the instance"
}

output "instance_private_ip" {
  value       = module.instance.private_ip
  description = "Private IP address of the instance"
}

output "ebs_volume_id" {
  value       = module.ebs_volume.volume_id
  description = "EBS volume ID"
}