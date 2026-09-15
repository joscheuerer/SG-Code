module "instance" {
  source   = "./modules/instance"
  for_each = var.instances

  ami                                  = each.value.ami
  instance_type                        = each.value.instance_type
  subnet_id                            = each.value.subnet_id
  vpc_security_group_ids               = each.value.vpc_security_group_ids
  associate_public_ip_address          = each.value.associate_public_ip_address
  availability_zone                    = each.value.availability_zone
  disable_api_stop                     = each.value.disable_api_stop
  disable_api_termination              = each.value.disable_api_termination
  ebs_optimized                        = each.value.ebs_optimized
  hibernation                          = each.value.hibernation
  instance_initiated_shutdown_behavior = each.value.instance_initiated_shutdown_behavior
  monitoring                           = each.value.monitoring
  source_dest_check                    = each.value.source_dest_check
  tenancy                              = each.value.tenancy
  tags                                 = each.value.tags
  volume_tags                          = each.value.volume_tags
  root_block_device                    = each.value.root_block_device
  credit_specification                 = each.value.credit_specification
  metadata_options                     = each.value.metadata_options
  private_dns_name_options             = each.value.private_dns_name_options
  maintenance_options                  = each.value.maintenance_options
}
