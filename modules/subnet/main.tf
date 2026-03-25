resource "aws_subnet" "this" {
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  availability_zone               = var.availability_zone
  cidr_block                      = var.cidr_block
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  vpc_id                          = var.vpc_id

  tags = var.tags
}