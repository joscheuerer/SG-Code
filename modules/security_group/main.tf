resource "aws_security_group" "this" {
  description = var.description
  name        = var.name
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "this" {
  for_each = var.ingress_rules

  type              = "ingress"
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.this.id
  self              = each.value.self
  to_port           = each.value.to_port
}

resource "aws_security_group_rule" "egress" {
  for_each = var.egress_rules

  type              = "egress"
  cidr_blocks       = each.value.cidr_blocks
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.this.id
  to_port           = each.value.to_port
}