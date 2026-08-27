# Manages a single EC2 instance and its configuration.
resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  source_dest_check      = var.source_dest_check
  tenancy                = var.tenancy
  ebs_optimized          = var.ebs_optimized

  # Instance metadata service options
  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = var.metadata_options.http_tokens
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
  }

  # Root block device configuration
  root_block_device {
    volume_type           = var.root_block_device.volume_type
    volume_size           = var.root_block_device.volume_size
    delete_on_termination = var.root_block_device.delete_on_termination
    encrypted             = var.root_block_device.encrypted
  }

  tags = var.tags

  # Lifecycle: ignore user_data changes (not surfaced by discovery)
  lifecycle {
    ignore_changes = [user_data]
  }
}
