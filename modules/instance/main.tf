resource "aws_instance" "this" {
  ami                  = var.ami
  availability_zone    = var.availability_zone
  ebs_optimized        = var.ebs_optimized
  iam_instance_profile = var.iam_instance_profile
  instance_type        = var.instance_type
  monitoring           = var.monitoring
  source_dest_check    = var.source_dest_check
  subnet_id            = var.subnet_id
  tenancy              = var.tenancy
  vpc_security_group_ids = var.vpc_security_group_ids
  tags                 = var.tags

  metadata_options {
    http_endpoint               = var.metadata_http_endpoint
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = var.metadata_http_tokens
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