resource "aws_instance" "this" {
  for_each = var.instances

  ami                         = each.value.ami_id
  associate_public_ip_address = each.value.associate_public_ip_address
  availability_zone           = each.value.availability_zone
  cpu_core_count              = each.value.cpu_core_count
  cpu_threads_per_core        = each.value.cpu_threads_per_core
  ebs_optimized               = each.value.ebs_optimized
  iam_instance_profile        = each.value.iam_instance_profile_arn
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  monitoring                  = each.value.monitoring_enabled
  source_dest_check           = each.value.source_dest_check
  subnet_id                   = each.value.subnet_id
  tenancy                     = each.value.tenancy
  vpc_security_group_ids      = each.value.security_group_ids

  root_block_device {
    delete_on_termination = each.value.root_delete_on_termination
    volume_size           = each.value.root_volume_size
    volume_type           = each.value.root_volume_type
  }

  metadata_options {
    http_endpoint               = each.value.metadata_http_endpoint
    http_protocol_ipv6          = each.value.metadata_http_protocol_ipv6
    http_put_response_hop_limit = each.value.metadata_hop_limit
    http_tokens                 = each.value.metadata_http_tokens
    instance_metadata_tags      = each.value.metadata_instance_tags
  }

  enclave_options {
    enabled = each.value.enclave_enabled
  }

  capacity_reservation_specification {
    capacity_reservation_preference = each.value.capacity_reservation_preference
  }

  tags = each.value.tags
}

resource "aws_ebs_volume" "this" {
  for_each = var.ebs_volumes

  availability_zone    = each.value.availability_zone
  encrypted            = each.value.encrypted
  iops                 = each.value.iops
  multi_attach_enabled = each.value.multi_attach_enabled
  size                 = each.value.size
  snapshot_id          = each.value.snapshot_id
  throughput           = each.value.throughput
  type                 = each.value.volume_type
}

resource "aws_volume_attachment" "this" {
  for_each = var.volume_attachments

  device_name                    = each.value.device_name
  instance_id                    = each.value.instance_id
  stop_instance_before_detaching = each.value.stop_instance_before_detaching
  volume_id                      = each.value.volume_id
}