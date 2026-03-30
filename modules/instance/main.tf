resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  ebs_optimized          = var.ebs_optimized
  hibernation            = var.hibernation
  monitoring             = var.monitoring
  source_dest_check      = var.source_dest_check
  cpu_core_count         = var.cpu_core_count
  cpu_threads_per_core   = var.cpu_threads_per_core

  enclave_options {
    enabled = var.enclave_enabled
  }

  metadata_options {
    http_endpoint               = var.metadata_http_endpoint
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = var.metadata_http_tokens
    instance_metadata_tags      = var.metadata_instance_metadata_tags
  }

  root_block_device {
    delete_on_termination = var.root_volume_delete_on_termination
    encrypted             = var.root_volume_encrypted
    iops                  = var.root_volume_iops
    throughput            = var.root_volume_throughput
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
  }
}