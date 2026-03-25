output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc_name.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = module.vpc_name_public_subnet.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.sg_runner_new_security_group.id
}

output "instance_ids" {
  description = "Map of instance keys to instance IDs"
  value       = module.instances.instance_ids
}

output "instance_private_ips" {
  description = "Map of instance keys to private IP addresses"
  value       = module.instances.instance_private_ips
}

output "instance_public_ips" {
  description = "Map of instance keys to public IP addresses"
  value       = module.instances.instance_public_ips
}