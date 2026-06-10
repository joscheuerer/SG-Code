resource "aws_default_network_acl" "this" {
  default_network_acl_id = var.default_network_acl_id
  subnet_ids             = var.subnet_ids

  dynamic "ingress" {
    for_each = var.ingress
    content {
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      protocol   = ingress.value.protocol
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = var.egress
    content {
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      protocol   = egress.value.protocol
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  tags = var.tags
}
