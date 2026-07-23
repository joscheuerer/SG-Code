variable "region" {
  type        = string
  description = "AWS region"
}

variable "vpc_name" {
  type        = string
  description = "Name for the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_instance_tenancy" {
  type        = string
  description = "Instance tenancy for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnet CIDR blocks"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnet CIDR blocks"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether to map public IP on launch for public subnets"
}

variable "create_igw" {
  type        = bool
  description = "Whether to create an internet gateway"
}

variable "create_vpc" {
  type        = bool
  description = "Whether to create the VPC"
}

variable "create_egress_only_igw" {
  type        = bool
  description = "Whether to create an egress-only internet gateway"
}

variable "manage_default_security_group" {
  type        = bool
  description = "Whether to manage the default security group"
}

variable "manage_default_network_acl" {
  type        = bool
  description = "Whether to manage the default network ACL"
}

variable "manage_default_route_table" {
  type        = bool
  description = "Whether to manage the default route table"
}

variable "cdk_assets_bucket_name" {
  type        = string
  description = "Name of the CDK assets S3 bucket"
}

variable "cdk_assets_block_public_acls" {
  type        = bool
  description = "Whether to block public ACLs for the CDK assets bucket"
}

variable "cdk_assets_block_public_policy" {
  type        = bool
  description = "Whether to block public policy for the CDK assets bucket"
}

variable "cdk_assets_ignore_public_acls" {
  type        = bool
  description = "Whether to ignore public ACLs for the CDK assets bucket"
}

variable "cdk_assets_restrict_public_buckets" {
  type        = bool
  description = "Whether to restrict public buckets for the CDK assets bucket"
}

variable "cdk_assets_versioning" {
  type        = map(string)
  description = "Versioning configuration for the CDK assets bucket"
  default     = {}
}

variable "cdk_assets_server_side_encryption_configuration" {
  type        = any
  description = "Server-side encryption configuration for the CDK assets bucket"
  default     = {}
}

variable "cdk_assets_lifecycle_rule" {
  type        = any
  description = "Lifecycle rules for the CDK assets bucket"
  default     = []
}

variable "cdk_assets_control_object_ownership" {
  type        = bool
  description = "Whether to control object ownership for the CDK assets bucket"
}

variable "cdk_assets_object_ownership" {
  type        = string
  description = "Object ownership setting for the CDK assets bucket"
}

variable "cdk_assets_tags" {
  type        = map(string)
  description = "Tags for the CDK assets bucket"
  default     = {}
}

variable "private_runner_storage_bucket_name" {
  type        = string
  description = "Name of the private runner storage S3 bucket"
}

variable "private_runner_storage_block_public_acls" {
  type        = bool
  description = "Whether to block public ACLs for the private runner storage bucket"
}

variable "private_runner_storage_block_public_policy" {
  type        = bool
  description = "Whether to block public policy for the private runner storage bucket"
}

variable "private_runner_storage_ignore_public_acls" {
  type        = bool
  description = "Whether to ignore public ACLs for the private runner storage bucket"
}

variable "private_runner_storage_restrict_public_buckets" {
  type        = bool
  description = "Whether to restrict public buckets for the private runner storage bucket"
}

variable "private_runner_storage_server_side_encryption_configuration" {
  type        = any
  description = "Server-side encryption configuration for the private runner storage bucket"
  default     = {}
}

variable "private_runner_storage_control_object_ownership" {
  type        = bool
  description = "Whether to control object ownership for the private runner storage bucket"
}

variable "private_runner_storage_object_ownership" {
  type        = string
  description = "Object ownership setting for the private runner storage bucket"
}

variable "instance_ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "instance_subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instance"
}

variable "instance_key_name" {
  type        = string
  description = "Key pair name for the EC2 instance"
}

variable "instance_iam_instance_profile" {
  type        = string
  description = "IAM instance profile for the EC2 instance"
}

variable "instance_source_dest_check" {
  type        = bool
  description = "Whether to enable source/destination check for the EC2 instance"
}

variable "instance_vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs for the EC2 instance"
}

variable "instance_availability_zone" {
  type        = string
  description = "Availability zone for the EC2 instance"
}

variable "instance_ebs_optimized" {
  type        = bool
  description = "Whether the EC2 instance is EBS optimized"
}

variable "instance_monitoring" {
  type        = bool
  description = "Whether detailed monitoring is enabled for the EC2 instance"
}

variable "instance_tenancy" {
  type        = string
  description = "Tenancy of the EC2 instance"
}

variable "instance_metadata_http_endpoint" {
  type        = string
  description = "Whether the metadata service is available for the EC2 instance"
}

variable "instance_metadata_http_protocol_ipv6" {
  type        = string
  description = "Whether the IPv6 endpoint for IMDS is enabled for the EC2 instance"
}

variable "instance_metadata_http_put_response_hop_limit" {
  type        = number
  description = "HTTP PUT response hop limit for instance metadata requests"
}

variable "instance_metadata_http_tokens" {
  type        = string
  description = "Whether IMDSv2 is required for the EC2 instance"
}

variable "instance_metadata_instance_metadata_tags" {
  type        = string
  description = "Whether instance tags are accessible from instance metadata"
}

variable "instance_tags" {
  type        = map(string)
  description = "Tags for the EC2 instance"
  default     = {}
}

variable "eni_subnet_id" {
  type        = string
  description = "Subnet ID for the ENI"
}

variable "eni_private_ips" {
  type        = list(string)
  description = "Private IP addresses for the ENI"
}

variable "eni_security_groups" {
  type        = list(string)
  description = "Security group IDs for the ENI"
}

variable "eni_source_dest_check" {
  type        = bool
  description = "Whether to enable source/destination check for the ENI"
}

variable "sg_vpc_id" {
  type        = string
  description = "VPC ID for security groups"
}

variable "sg_launch_wizard_name" {
  type        = string
  description = "Name of the launch-wizard security group"
}

variable "sg_launch_wizard_description" {
  type        = string
  description = "Description of the launch-wizard security group"
}

variable "sg_default_name" {
  type        = string
  description = "Name of the default security group"
}

variable "sg_default_description" {
  type        = string
  description = "Description of the default security group"
}

variable "sg_launch_wizard_1_name" {
  type        = string
  description = "Name of the launch-wizard-1 security group"
}

variable "sg_launch_wizard_1_description" {
  type        = string
  description = "Description of the launch-wizard-1 security group"
}

variable "nacl_vpc_id" {
  type        = string
  description = "VPC ID for the network ACL"
}

variable "nacl_subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to associate with the network ACL"
}