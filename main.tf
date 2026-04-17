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
  map_public_ip_on_launch         = var.subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.subnet_assign_ipv6_address_on_creation
  tags                            = var.subnet_tags
}

module "security_group" {
  source      = "./modules/security_group"
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = module.vpc.vpc_id
  ingress     = var.security_group_ingress
  egress      = var.security_group_egress
}

module "ebs_volume" {
  source               = "./modules/ebs_volume"
  availability_zone    = var.ebs_availability_zone
  size                 = var.ebs_size
  type                 = var.ebs_type
  iops                 = var.ebs_iops
  throughput           = var.ebs_throughput
  encrypted            = var.ebs_encrypted
  multi_attach_enabled = var.ebs_multi_attach_enabled
  snapshot_id          = var.ebs_snapshot_id
}

module "instance" {
  source                                  = "./modules/instance"
  ami                                     = var.instance_ami
  instance_type                           = var.instance_instance_type
  subnet_id                               = module.subnet.subnet_id
  vpc_security_group_ids                  = [module.security_group.security_group_id]
  key_name                                = var.instance_key_name
  availability_zone                       = var.instance_availability_zone
  tenancy                                 = var.instance_tenancy
  source_dest_check                       = var.instance_source_dest_check
  ebs_optimized                           = var.instance_ebs_optimized
  monitoring                              = var.instance_monitoring
  metadata_http_endpoint                  = var.instance_metadata_http_endpoint
  metadata_http_protocol_ipv6             = var.instance_metadata_http_protocol_ipv6
  metadata_http_put_response_hop_limit    = var.instance_metadata_http_put_response_hop_limit
  metadata_http_tokens                    = var.instance_metadata_http_tokens
  metadata_instance_metadata_tags         = var.instance_metadata_instance_metadata_tags
  capacity_reservation_preference         = var.instance_capacity_reservation_preference
  enclave_options_enabled                 = var.instance_enclave_options_enabled
  root_block_device_delete_on_termination = var.instance_root_block_device_delete_on_termination
}

module "network_interface" {
  source               = "./modules/network_interface"
  subnet_id            = module.subnet.subnet_id
  private_ips          = var.eni_private_ips
  security_groups      = [module.security_group.security_group_id]
  source_dest_check    = var.eni_source_dest_check
  attached_instance_id = module.instance.instance_id
  device_index         = var.eni_device_index
}