resource "aws_instance" "this" {
  ami                         = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.availability_zone
  ebs_optimized               = var.ebs_optimized
  iam_instance_profile        = var.iam_instance_profile
  instance_type               = var.instance_type
  key_name                    = var.key_name
  monitoring                  = var.monitoring
  source_dest_check           = var.source_dest_check
  subnet_id                   = var.subnet_id
  tags                        = var.tags
  tenancy                     = var.tenancy
  volume_tags                 = var.volume_tags
  vpc_security_group_ids      = var.vpc_security_group_ids

  capacity_reservation_specification {
    capacity_reservation_preference = var.capacity_reservation_preference
  }

  enclave_options {
    enabled = var.enclave_options_enabled
  }

  metadata_options {
    http_endpoint               = var.metadata_http_endpoint
    http_protocol_ipv6          = var.metadata_http_protocol_ipv6
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = var.metadata_http_tokens
    instance_metadata_tags      = var.metadata_instance_metadata_tags
  }

  root_block_device {
    delete_on_termination = var.root_block_device_delete_on_termination
    encrypted             = var.root_block_device_encrypted
    iops                  = var.root_block_device_iops
    volume_size           = var.root_block_device_volume_size
    volume_type           = var.root_block_device_volume_type
  }
}