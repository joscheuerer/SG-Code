resource "aws_instance" "this" {
  ami                    = var.ami
  availability_zone      = var.availability_zone
  ebs_optimized          = var.ebs_optimized
  iam_instance_profile   = var.iam_instance_profile
  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = var.monitoring
  source_dest_check      = var.source_dest_check
  subnet_id              = var.subnet_id
  tags                   = var.tags
  tenancy                = var.tenancy
  vpc_security_group_ids = var.vpc_security_group_ids

  metadata_options {
    http_endpoint               = var.metadata_http_endpoint
    http_protocol_ipv6          = var.metadata_http_protocol_ipv6
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = var.metadata_http_tokens
    instance_metadata_tags      = var.metadata_instance_metadata_tags
  }
}