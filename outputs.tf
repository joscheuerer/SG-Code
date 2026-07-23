output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.igw_id
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.instance.instance_id
}

output "instance_private_ip" {
  description = "The private IP of the EC2 instance"
  value       = module.instance.private_ip
}

output "network_interface_id" {
  description = "The ID of the network interface"
  value       = module.network_interface.network_interface_id
}

output "sg_launch_wizard_id" {
  description = "The ID of the launch-wizard security group"
  value       = module.security_group_launch_wizard.security_group_id
}

output "sg_default_id" {
  description = "The ID of the default security group"
  value       = module.security_group_default.security_group_id
}

output "sg_launch_wizard_1_id" {
  description = "The ID of the launch-wizard-1 security group"
  value       = module.security_group_launch_wizard_1.security_group_id
}

output "network_acl_id" {
  description = "The ID of the network ACL"
  value       = module.network_acl.network_acl_id
}

output "cdk_assets_bucket_id" {
  description = "The ID of the CDK assets S3 bucket"
  value       = module.cdk_assets_bucket.s3_bucket_id
}

output "private_runner_storage_bucket_id" {
  description = "The ID of the private runner storage S3 bucket"
  value       = module.private_runner_storage_bucket.s3_bucket_id
}