resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone
  encrypted         = false
  iops              = var.iops
  multi_attach_enabled = false
  size              = var.size
  throughput        = var.throughput
  type              = var.volume_type
}