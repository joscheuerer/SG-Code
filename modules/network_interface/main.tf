resource "aws_network_interface" "this" {
  description       = var.description
  private_ips       = var.private_ips
  security_groups   = var.security_groups
  source_dest_check = var.source_dest_check
  subnet_id         = var.subnet_id
  tags              = var.tags
}

resource "aws_network_interface_attachment" "this" {
  device_index         = var.device_index
  instance_id          = var.instance_id
  network_interface_id = aws_network_interface.this.id
}