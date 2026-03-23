resource "aws_security_group" "this" {
  for_each = var.security_groups

  description = each.value.description
  name        = each.value.name
  vpc_id      = var.vpc_id
  tags        = each.value.tags
}

resource "aws_security_group_rule" "this" {
  for_each = var.security_group_rules

  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.this[each.value.security_group_key].id
  to_port           = each.value.to_port
  type              = each.value.type
}