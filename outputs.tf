output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the VPC"
}

output "subnet_ids" {
  value       = module.subnets.subnet_ids
  description = "Map of subnet keys to subnet IDs"
}

output "internet_gateway_id" {
  value       = module.internet_gateway.internet_gateway_id
  description = "ID of the internet gateway"
}

output "route_table_ids" {
  value       = module.route_tables.route_table_ids
  description = "Map of route table keys to route table IDs"
}

output "security_group_id" {
  value       = module.security_group.security_group_id
  description = "ID of the security group"
}

output "network_acl_id" {
  value       = module.network_acl.network_acl_id
  description = "ID of the network ACL"
}