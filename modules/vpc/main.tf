resource "aws_vpc" "this" {
  cidr_block         = var.cidr_block
  enable_dns_support = var.enable_dns_support
  instance_tenancy   = var.instance_tenancy
  tags               = var.tags
}