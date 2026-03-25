resource "aws_ebs_volume" "this" {
  for_each = var.volumes

  availability_zone     = each.value.availability_zone
  encrypted             = each.value.encrypted
  iops                  = each.value.iops
  multi_attach_enabled  = each.value.multi_attach_enabled
  size                  = each.value.size
  snapshot_id           = each.value.snapshot_id
  throughput            = each.value.throughput
  type                  = each.value.volume_type
  tags                  = each.value.tags
}