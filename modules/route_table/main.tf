resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  tags   = var.tags
}

resource "aws_route_table_association" "this" {
  for_each = var.subnet_associations

  subnet_id      = each.value.subnet_id
  route_table_id = aws_route_table.this.id
}