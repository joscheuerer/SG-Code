module "iam_instance_profile" {
  source = "./modules/iam_instance_profile"

  name = var.instance_profile_name
  path = var.instance_profile_path
  role = var.instance_profile_role
}

module "key_pair" {
  source = "./modules/key_pair"

  key_name   = var.key_pair_key_name
  public_key = var.key_pair_public_key
}

module "instance" {
  source   = "./modules/instance"
  for_each = var.instances

  ami                         = each.value.ami
  associate_public_ip_address = each.value.associate_public_ip_address
  availability_zone           = each.value.availability_zone
  ebs_optimized               = each.value.ebs_optimized
  iam_instance_profile        = each.value.iam_instance_profile
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  monitoring                  = each.value.monitoring
  source_dest_check           = each.value.source_dest_check
  subnet_id                   = each.value.subnet_id
  tags                        = each.value.tags
  tenancy                     = each.value.tenancy
  volume_tags                 = each.value.volume_tags
  vpc_security_group_ids      = each.value.vpc_security_group_ids

  capacity_reservation_preference = each.value.capacity_reservation_preference
  enclave_options_enabled         = each.value.enclave_options_enabled

  metadata_http_endpoint               = each.value.metadata_http_endpoint
  metadata_http_protocol_ipv6          = each.value.metadata_http_protocol_ipv6
  metadata_http_put_response_hop_limit = each.value.metadata_http_put_response_hop_limit
  metadata_http_tokens                 = each.value.metadata_http_tokens
  metadata_instance_metadata_tags      = each.value.metadata_instance_metadata_tags

  root_block_device_delete_on_termination = each.value.root_block_device_delete_on_termination
  root_block_device_encrypted             = each.value.root_block_device_encrypted
  root_block_device_iops                  = each.value.root_block_device_iops
  root_block_device_volume_size           = each.value.root_block_device_volume_size
  root_block_device_volume_type           = each.value.root_block_device_volume_type
}

module "network_interface" {
  source = "./modules/network_interface"

  subnet_id         = var.eni_subnet_id
  private_ips       = var.eni_private_ips
  security_groups   = var.eni_security_groups
  source_dest_check = var.eni_source_dest_check
}