module "iam_instance_profile" {
  source = "./modules/iam_instance_profile"

  name = var.iam_instance_profile_name
  path = var.iam_instance_profile_path
  role = var.iam_instance_profile_role
}

module "key_pair" {
  source = "./modules/key_pair"

  key_name   = var.key_pair_key_name
  public_key = var.key_pair_public_key
}

module "instance" {
  source = "./modules/instance"

  ami                                     = var.instance_ami
  availability_zone                       = var.instance_availability_zone
  capacity_reservation_preference         = var.instance_capacity_reservation_preference
  cpu_core_count                          = var.instance_cpu_core_count
  cpu_threads_per_core                    = var.instance_cpu_threads_per_core
  ebs_optimized                           = var.instance_ebs_optimized
  enclave_options_enabled                 = var.instance_enclave_options_enabled
  iam_instance_profile                    = module.iam_instance_profile.name
  instance_type                           = var.instance_instance_type
  key_name                                = module.key_pair.key_name
  metadata_http_endpoint                  = var.instance_metadata_http_endpoint
  metadata_http_protocol_ipv6             = var.instance_metadata_http_protocol_ipv6
  metadata_http_put_response_hop_limit    = var.instance_metadata_http_put_response_hop_limit
  metadata_http_tokens                    = var.instance_metadata_http_tokens
  metadata_instance_metadata_tags         = var.instance_metadata_instance_metadata_tags
  monitoring                              = var.instance_monitoring
  root_block_device_delete_on_termination = var.instance_root_block_device_delete_on_termination
  source_dest_check                       = var.instance_source_dest_check
  subnet_id                               = var.instance_subnet_id
  tags                                    = var.instance_tags
  tenancy                                 = var.instance_tenancy
  vpc_security_group_ids                  = var.instance_vpc_security_group_ids
}