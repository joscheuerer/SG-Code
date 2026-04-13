module "vpc" {
  source = "./modules/vpc"

  cidr_block         = var.vpc_cidr_block
  enable_dns_support = var.vpc_enable_dns_support
  instance_tenancy   = var.vpc_instance_tenancy
  tags               = var.vpc_tags
}

module "subnet" {
  source = "./modules/subnet"

  vpc_id                          = module.vpc.vpc_id
  cidr_block                      = var.subnet_cidr_block
  availability_zone               = var.subnet_availability_zone
  map_public_ip_on_launch         = var.subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.subnet_assign_ipv6_address_on_creation
  tags                            = var.subnet_tags
}

module "security_group" {
  source = "./modules/security_group"

  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = module.vpc.vpc_id
}

module "ebs_volume" {
  source = "./modules/ebs_volume"

  availability_zone    = var.ebs_availability_zone
  size                 = var.ebs_size
  type                 = var.ebs_type
  iops                 = var.ebs_iops
  encrypted            = var.ebs_encrypted
  multi_attach_enabled = var.ebs_multi_attach_enabled
  snapshot_id          = var.ebs_snapshot_id
}

module "instance" {
  source = "./modules/instance"

  ami_id                 = var.instance_ami_id
  instance_type          = var.instance_instance_type
  key_name               = var.instance_key_name
  subnet_id              = module.subnet.subnet_id
  vpc_security_group_ids = var.instance_vpc_security_group_ids
  availability_zone      = var.instance_availability_zone
  source_dest_check      = var.instance_source_dest_check
  ebs_optimized          = var.instance_ebs_optimized
  monitoring             = var.instance_monitoring
  tenancy                = var.instance_tenancy
  private_ips            = var.instance_private_ips
}