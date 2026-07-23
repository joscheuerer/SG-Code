module "vpc" {
  source = "git::https://github.com/StackGuardian/terraform-aws-vpc.git"

  name                           = var.vpc_name
  cidr                           = var.vpc_cidr
  instance_tenancy               = var.vpc_instance_tenancy
  azs                            = var.azs
  public_subnets                 = var.public_subnets
  private_subnets                = var.private_subnets
  map_public_ip_on_launch        = var.map_public_ip_on_launch
  create_igw                     = var.create_igw
  create_vpc                     = var.create_vpc
  create_egress_only_igw         = var.create_egress_only_igw
  manage_default_security_group  = var.manage_default_security_group
  manage_default_network_acl     = var.manage_default_network_acl
  manage_default_route_table     = var.manage_default_route_table
}

module "cdk_assets_bucket" {
  source = "git::https://github.com/StackGuardian/module-tf-aws-s3-bucket.git?ref=v3.6.2-sg"

  bucket                              = var.cdk_assets_bucket_name
  block_public_acls                   = var.cdk_assets_block_public_acls
  block_public_policy                 = var.cdk_assets_block_public_policy
  ignore_public_acls                  = var.cdk_assets_ignore_public_acls
  restrict_public_buckets             = var.cdk_assets_restrict_public_buckets
  versioning                          = var.cdk_assets_versioning
  server_side_encryption_configuration = var.cdk_assets_server_side_encryption_configuration
  lifecycle_rule                      = var.cdk_assets_lifecycle_rule
  control_object_ownership            = var.cdk_assets_control_object_ownership
  object_ownership                    = var.cdk_assets_object_ownership
  tags                                = var.cdk_assets_tags
}

module "private_runner_storage_bucket" {
  source = "git::https://github.com/StackGuardian/module-tf-aws-s3-bucket.git?ref=v3.6.2-sg"

  bucket                              = var.private_runner_storage_bucket_name
  block_public_acls                   = var.private_runner_storage_block_public_acls
  block_public_policy                 = var.private_runner_storage_block_public_policy
  ignore_public_acls                  = var.private_runner_storage_ignore_public_acls
  restrict_public_buckets             = var.private_runner_storage_restrict_public_buckets
  server_side_encryption_configuration = var.private_runner_storage_server_side_encryption_configuration
  control_object_ownership            = var.private_runner_storage_control_object_ownership
  object_ownership                    = var.private_runner_storage_object_ownership
}

module "instance" {
  source = "./modules/instance"

  ami                                  = var.instance_ami
  instance_type                        = var.instance_type
  subnet_id                            = var.instance_subnet_id
  key_name                             = var.instance_key_name
  iam_instance_profile                 = var.instance_iam_instance_profile
  source_dest_check                    = var.instance_source_dest_check
  vpc_security_group_ids               = var.instance_vpc_security_group_ids
  availability_zone                    = var.instance_availability_zone
  ebs_optimized                        = var.instance_ebs_optimized
  monitoring                           = var.instance_monitoring
  tenancy                              = var.instance_tenancy
  metadata_http_endpoint               = var.instance_metadata_http_endpoint
  metadata_http_protocol_ipv6          = var.instance_metadata_http_protocol_ipv6
  metadata_http_put_response_hop_limit = var.instance_metadata_http_put_response_hop_limit
  metadata_http_tokens                 = var.instance_metadata_http_tokens
  metadata_instance_metadata_tags      = var.instance_metadata_instance_metadata_tags
  tags                                 = var.instance_tags
}

module "network_interface" {
  source = "./modules/network_interface"

  subnet_id         = var.eni_subnet_id
  private_ips       = var.eni_private_ips
  security_groups   = var.eni_security_groups
  source_dest_check = var.eni_source_dest_check
}

module "security_group_launch_wizard" {
  source = "./modules/security_group_launch_wizard"

  name        = var.sg_launch_wizard_name
  description = var.sg_launch_wizard_description
  vpc_id      = var.sg_vpc_id
}

module "security_group_default" {
  source = "./modules/security_group_default"

  name        = var.sg_default_name
  description = var.sg_default_description
  vpc_id      = var.sg_vpc_id
}

module "security_group_launch_wizard_1" {
  source = "./modules/security_group_launch_wizard_1"

  name        = var.sg_launch_wizard_1_name
  description = var.sg_launch_wizard_1_description
  vpc_id      = var.sg_vpc_id
}

module "network_acl" {
  source = "./modules/network_acl"

  vpc_id     = var.nacl_vpc_id
  subnet_ids = var.nacl_subnet_ids
}