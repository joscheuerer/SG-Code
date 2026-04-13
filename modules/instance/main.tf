resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  availability_zone      = var.availability_zone
  source_dest_check      = var.source_dest_check
  ebs_optimized          = var.ebs_optimized
  monitoring             = var.monitoring
  tenancy                = var.tenancy

  capacity_reservation_specification {
    capacity_reservation_preference = var.capacity_reservation_preference
  }

  cpu_options {
    core_count       = var.cpu_core_count
    threads_per_core = var.cpu_threads_per_core
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
  }
}