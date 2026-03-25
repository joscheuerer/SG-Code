resource "aws_network_interface" "this" {
  description       = var.description
  private_ips       = var.private_ips
  source_dest_check = false
  subnet_id         = var.subnet_id
}