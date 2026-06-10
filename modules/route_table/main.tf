resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = [for r in var.routes : r if r.use_igw]
    content {
      cidr_block = route.value.cidr_block
      gateway_id = var.internet_gateway_id
    }
  }

  tags = var.tags
}
