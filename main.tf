module "vpc" {
  source           = "./modules/vpc"
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.vpc_instance_tenancy
  tags             = var.vpc_tags
}

module "subnet" {
  source                          = "./modules/subnet"
  vpc_id                          = module.vpc.vpc_id
  cidr_block                      = var.subnet_cidr_block
  availability_zone               = var.subnet_availability_zone
  assign_ipv6_address_on_creation = var.subnet_assign_ipv6_address_on_creation
  map_public_ip_on_launch         = var.subnet_map_public_ip_on_launch
  tags                            = var.subnet_tags
}

module "security_group" {
  source      = "./modules/security_group"
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = module.vpc.vpc_id
  ingress     = var.security_group_ingress
  egress      = var.security_group_egress
  tags        = var.security_group_tags
}

module "key_pair" {
  source     = "./modules/key_pair"
  key_name   = var.key_pair_key_name
  public_key = var.key_pair_public_key
}

module "iam_instance_profile" {
  source = "./modules/iam_instance_profile"
  name   = var.iam_instance_profile_name
  path   = var.iam_instance_profile_path
  role   = var.iam_instance_profile_role
}

module "ebs_volume" {
  source               = "./modules/ebs_volume"
  availability_zone    = var.ebs_volume_availability_zone
  size                 = var.ebs_volume_size
  type                 = var.ebs_volume_type
  iops                 = var.ebs_volume_iops
  throughput           = var.ebs_volume_throughput
  encrypted            = var.ebs_volume_encrypted
  multi_attach_enabled = var.ebs_volume_multi_attach_enabled
  snapshot_id          = var.ebs_volume_snapshot_id
  tags                 = var.ebs_volume_tags
}

module "network_interface" {
  source            = "./modules/network_interface"
  subnet_id         = module.subnet.subnet_id
  private_ips       = var.network_interface_private_ips
  security_groups   = [module.security_group.security_group_id]
  source_dest_check = var.network_interface_source_dest_check
  tags              = var.network_interface_tags
}

module "instance" {
  source                                  = "./modules/instance"
  ami                                     = var.instance_ami
  instance_type                           = var.instance_instance_type
  subnet_id                               = module.subnet.subnet_id
  key_name                                = module.key_pair.key_name
  iam_instance_profile                    = module.iam_instance_profile.instance_profile_name
  vpc_security_group_ids                  = [module.security_group.security_group_id]
  availability_zone                       = var.instance_availability_zone
  source_dest_check                       = var.instance_source_dest_check
  ebs_optimized                           = var.instance_ebs_optimized
  monitoring                              = var.instance_monitoring
  tenancy                                 = var.instance_tenancy
  metadata_http_endpoint                  = var.instance_metadata_http_endpoint
  metadata_http_protocol_ipv6             = var.instance_metadata_http_protocol_ipv6
  metadata_http_put_response_hop_limit    = var.instance_metadata_http_put_response_hop_limit
  metadata_http_tokens                    = var.instance_metadata_http_tokens
  metadata_instance_metadata_tags         = var.instance_metadata_instance_metadata_tags
  enclave_options_enabled                 = var.instance_enclave_options_enabled
  capacity_reservation_preference         = var.instance_capacity_reservation_preference
  root_block_device_delete_on_termination = var.instance_root_block_device_delete_on_termination
  root_block_device_volume_size           = var.instance_root_block_device_volume_size
  tags                                    = var.instance_tags
}