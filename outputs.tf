output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = module.subnet.subnet_id
}

output "security_group_id" {
  description = "Security group ID"
  value       = module.security_group.security_group_id
}

output "instance_id" {
  description = "Instance ID"
  value       = module.instance.instance_id
}

output "instance_private_ip" {
  description = "Instance private IP"
  value       = module.instance.private_ip
}

output "ebs_volume_id" {
  description = "EBS volume ID"
  value       = module.ebs_volume.volume_id
}