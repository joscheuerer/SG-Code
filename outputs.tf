output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "subnet_id" {
  value       = module.subnet_private_1b.subnet_id
  description = "The ID of the private subnet"
}

output "route_table_id" {
  value       = module.route_table_private_1b.route_table_id
  description = "The ID of the route table"
}

output "network_acl_id" {
  value       = module.network_acl.network_acl_id
  description = "The ID of the network ACL"
}