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

output "additional_network_interface_id" {
  description = "Additional network interface ID"
  value       = module.network_interface.network_interface_id
}