resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  route  = var.routes
  tags   = var.tags
}