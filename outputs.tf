output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "subnet_ids" {
  value       = module.subnets.subnet_ids
  description = "Map of subnet keys to subnet IDs"
}

output "internet_gateway_id" {
  value       = module.internet_gateway.internet_gateway_id
  description = "Internet gateway ID"
}

output "route_table_ids" {
  value       = module.route_tables.route_table_ids
  description = "Map of route table keys to route table IDs"
}

output "security_group_ids" {
  value       = module.security_groups.security_group_ids
  description = "Map of security group keys to security group IDs"
}

output "network_acl_id" {
  value       = module.network_acl.network_acl_id
  description = "Network ACL ID"
}