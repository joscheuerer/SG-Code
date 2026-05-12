resource "aws_default_network_acl" "this" {
  default_network_acl_id = var.default_network_acl_id
  subnet_ids             = var.subnet_ids
  tags                   = var.tags

  dynamic "egress" {
    for_each = var.egress
    content {
      rule_no         = egress.value.rule_no
      action          = egress.value.action
      protocol        = egress.value.protocol
      cidr_block      = lookup(egress.value, "cidr_block", null)
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null)
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      icmp_type       = lookup(egress.value, "icmp_type", null)
      icmp_code       = lookup(egress.value, "icmp_code", null)
    }
  }

  dynamic "ingress" {
    for_each = var.ingress
    content {
      rule_no         = ingress.value.rule_no
      action          = ingress.value.action
      protocol        = ingress.value.protocol
      cidr_block      = lookup(ingress.value, "cidr_block", null)
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null)
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      icmp_type       = lookup(ingress.value, "icmp_type", null)
      icmp_code       = lookup(ingress.value, "icmp_code", null)
    }
  }
}