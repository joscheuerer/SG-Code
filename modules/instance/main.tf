resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  availability_zone      = var.availability_zone
  source_dest_check      = var.source_dest_check
  ebs_optimized          = var.ebs_optimized
  monitoring             = var.monitoring
  tenancy                = var.tenancy
}

resource "aws_network_interface" "this" {
  subnet_id         = var.subnet_id
  private_ips       = var.private_ips
  security_groups   = var.vpc_security_group_ids
  source_dest_check = var.source_dest_check
}