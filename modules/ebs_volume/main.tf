resource "aws_ebs_volume" "this" {
  availability_zone    = var.availability_zone
  size                 = var.size
  type                 = var.type
  iops                 = var.iops
  throughput           = var.throughput
  encrypted            = var.encrypted
  multi_attach_enabled = var.multi_attach_enabled
  snapshot_id          = var.snapshot_id
}