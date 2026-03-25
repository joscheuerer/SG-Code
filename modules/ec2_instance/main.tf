resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  source_dest_check      = var.source_dest_check
  ebs_optimized          = var.ebs_optimized
  monitoring             = var.monitoring
  hibernation            = var.hibernation

  enclave_options {
    enabled = var.enclave_enabled
  }

  metadata_options {
    http_endpoint               = var.metadata_http_endpoint
    http_tokens                 = var.metadata_http_tokens
    http_put_response_hop_limit = var.metadata_hop_limit
    instance_metadata_tags      = var.metadata_instance_tags
  }

  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    iops                  = var.root_volume_iops
    throughput            = var.root_volume_throughput
    encrypted             = var.root_volume_encrypted
    delete_on_termination = var.root_delete_on_termination
  }

  tags = var.tags
}

resource "aws_ebs_volume" "this" {
  availability_zone    = var.availability_zone
  size                 = var.root_volume_size
  type                 = var.root_volume_type
  iops                 = var.root_volume_iops
  throughput           = var.root_volume_throughput
  encrypted            = var.root_volume_encrypted
  snapshot_id          = var.snapshot_id
  multi_attach_enabled = var.multi_attach_enabled
}