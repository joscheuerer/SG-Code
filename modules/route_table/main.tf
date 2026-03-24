resource "aws_route_table" "this" {
  for_each = var.route_tables

  vpc_id = var.vpc_id
  tags   = each.value.tags
}

resource "aws_route" "this" {
  for_each = var.routes

  destination_cidr_block = each.value.destination_cidr_block
  gateway_id             = each.value.gateway_id
  route_table_id         = aws_route_table.this[each.value.route_table_key].id
}

resource "aws_route_table_association" "this" {
  for_each = var.route_table_associations

  route_table_id = aws_route_table.this[each.value.route_table_key].id
  subnet_id      = each.value.subnet_id
}