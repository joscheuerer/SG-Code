resource "aws_security_group" "this" {
  name        = var.group_name
  description = var.description
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "this" {
  for_each = var.ingress_rules

  type              = "ingress"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  to_port           = each.value.to_port
}

resource "aws_security_group_rule" "egress" {
  for_each = var.egress_rules

  type              = "egress"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  to_port           = each.value.to_port
}