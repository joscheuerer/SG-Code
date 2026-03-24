resource "aws_security_group" "this" {
  description = var.description
  name        = var.name
  vpc_id      = var.vpc_id
  tags        = var.tags
}