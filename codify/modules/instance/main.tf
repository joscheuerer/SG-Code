resource "aws_instance" "this" {
  for_each = var.instances

  ami                         = each.value.ami_id
  associate_public_ip_address = each.value.associate_public_ip_address
  availability_zone           = each.value.availability_zone
  cpu_core_count              = each.value.cpu_core_count
  cpu_threads_per_core        = each.value.cpu_threads_per_core
  ebs_optimized               = each.value.ebs_optimized
  hibernation                 = each.value.hibernation
  iam_instance_profile        = each.value.iam_instance_profile_arn
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  monitoring                  = each.value.monitoring
  source_dest_check           = each.value.source_dest_check
  subnet_id                   = each.value.subnet_id
  tenancy                     = each.value.tenancy
  vpc_security_group_ids      = each.value.security_group_ids

  capacity_reservation_specification {
    capacity_reservation_preference = each.value.capacity_reservation_specification.capacity_reservation_preference
  }

  enclave_options {
    enabled = each.value.enclave_options.enabled
  }

  metadata_options {
    http_endpoint               = each.value.metadata_options.http_endpoint
    http_protocol_ipv6          = each.value.metadata_options.http_protocol_ipv6
    http_put_response_hop_limit = each.value.metadata_options.http_put_response_hop_limit
    http_tokens                 = each.value.metadata_options.http_tokens
    instance_metadata_tags      = each.value.metadata_options.instance_metadata_tags
  }

  root_block_device {
    delete_on_termination = each.value.root_block_device.delete_on_termination
    volume_type           = each.value.root_block_device.volume_type
  }

  tags = each.value.tags
}

resource "aws_ebs_volume" "this" {
  for_each = var.additional_ebs_volumes

  availability_zone = each.value.availability_zone
  encrypted         = each.value.encrypted
  size              = each.value.size
  type              = each.value.type

  tags = each.value.tags
}

resource "aws_volume_attachment" "this" {
  for_each = var.additional_ebs_volumes

  device_name  = each.value.device_name
  force_detach = each.value.force_detach
  instance_id  = aws_instance.this[each.value.instance_key].id
  volume_id    = aws_ebs_volume.this[each.key].id
}