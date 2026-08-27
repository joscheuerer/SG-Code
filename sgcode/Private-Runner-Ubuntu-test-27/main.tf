# Root module — wires module calls; no bare resource blocks.

# EC2 instances
module "instance" {
  source   = "./modules/instance-not-really"
  for_each = var.instances

  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = each.value.vpc_security_group_ids
  source_dest_check      = each.value.source_dest_check
  tenancy                = each.value.tenancy
  ebs_optimized          = each.value.ebs_optimized
  metadata_options       = each.value.metadata_options
  root_block_device      = each.value.root_block_device
  tags                   = each.value.tags
}

# EBS volumes (standalone, not root volumes)
module "ebs_volume" {
  source   = "./modules/ebs_volume"
  for_each = var.ebs_volumes

  availability_zone    = each.value.availability_zone
  size                 = each.value.size
  type                 = each.value.type
  iops                 = each.value.iops
  throughput           = each.value.throughput
  encrypted            = each.value.encrypted
  multi_attach_enabled = each.value.multi_attach_enabled
  tags                 = each.value.tags
}

# Key pairs — public_key supplied via separate sensitive variable
module "key_pair" {
  source   = "./modules/key_pair"
  for_each = var.key_pairs

  key_name   = each.value.key_name
  public_key = lookup(var.key_pair_public_keys, each.key, "placeholder")
  tags       = each.value.tags
}