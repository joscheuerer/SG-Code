resource "aws_network_interface" "this" {
  private_ips       = var.private_ips
  security_groups   = var.security_groups
  source_dest_check = var.source_dest_check
  subnet_id         = var.subnet_id
}