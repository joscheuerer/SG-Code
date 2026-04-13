output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = module.subnet.subnet_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.security_group.security_group_id
}

output "ebs_volume_id" {
  description = "The ID of the EBS volume"
  value       = module.ebs_volume.volume_id
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.instance.instance_id
}

output "network_interface_id" {
  description = "The ID of the network interface"
  value       = module.instance.network_interface_id
}