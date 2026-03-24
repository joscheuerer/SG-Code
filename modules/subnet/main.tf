resource "aws_subnet" "this" {
  for_each = var.subnets

  availability_zone       = each.value.availability_zone
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  vpc_id                  = var.vpc_id
  tags                    = each.value.tags
}