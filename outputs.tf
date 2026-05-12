output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_basic_eks_public_eu_central_1b_id" {
  description = "The ID of the basic-eks-public-eu-central-1b subnet"
  value       = module.subnet["basic_eks_public_eu_central_1b"].subnet_id
}

output "subnet_basic_eks_private_eu_central_1b_id" {
  description = "The ID of the basic-eks-private-eu-central-1b subnet"
  value       = module.subnet["basic_eks_private_eu_central_1b"].subnet_id
}

output "subnet_basic_eks_public_eu_central_1a_id" {
  description = "The ID of the basic-eks-public-eu-central-1a subnet"
  value       = module.subnet["basic_eks_public_eu_central_1a"].subnet_id
}

output "subnet_basic_eks_private_eu_central_1c_id" {
  description = "The ID of the basic-eks-private-eu-central-1c subnet"
  value       = module.subnet["basic_eks_private_eu_central_1c"].subnet_id
}

output "subnet_basic_eks_public_eu_central_1c_id" {
  description = "The ID of the basic-eks-public-eu-central-1c subnet"
  value       = module.subnet["basic_eks_public_eu_central_1c"].subnet_id
}

output "subnet_basic_eks_private_eu_central_1a_id" {
  description = "The ID of the basic-eks-private-eu-central-1a subnet"
  value       = module.subnet["basic_eks_private_eu_central_1a"].subnet_id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = module.internet_gateway.internet_gateway_id
}

output "route_table_basic_eks_private_id" {
  description = "The ID of the basic-eks-private route table"
  value       = module.route_table["basic_eks_private"].route_table_id
}

output "route_table_basic_eks_public_id" {
  description = "The ID of the basic-eks-public route table"
  value       = module.route_table["basic_eks_public"].route_table_id
}

output "route_table_basic_eks_default_id" {
  description = "The ID of the basic-eks-default route table"
  value       = module.route_table["basic_eks_default"].route_table_id
}

output "security_group_basic_eks_cluster_id" {
  description = "The ID of the basic-eks-cluster security group"
  value       = module.security_group["basic_eks_cluster"].security_group_id
}

output "security_group_outpost_id" {
  description = "The ID of the outpost security group"
  value       = module.security_group["outpost"].security_group_id
}

output "security_group_basic_eks_node_id" {
  description = "The ID of the basic-eks-node security group"
  value       = module.security_group["basic_eks_node"].security_group_id
}

output "security_group_default_id" {
  description = "The ID of the default security group"
  value       = module.security_group["default"].security_group_id
}

output "network_acl_id" {
  description = "The ID of the network ACL"
  value       = module.network_acl.network_acl_id
}