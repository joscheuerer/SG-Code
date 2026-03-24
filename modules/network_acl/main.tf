resource "aws_network_acl" "this" {
  subnet_ids = var.subnet_ids
  vpc_id     = var.vpc_id
}

resource "aws_network_acl_rule" "this" {
  for_each = var.acl_rules

  cidr_block     = each.value.cidr_block
  egress         = each.value.egress
  network_acl_id = aws_network_acl.this.id
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  rule_number    = each.value.rule_number
}