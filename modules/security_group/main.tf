resource "aws_security_group" "this" {
  description = var.description
  name        = var.name
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "this" {
  for_each = var.rules

  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.this.id
  to_port           = each.value.to_port
  type              = each.value.type
}