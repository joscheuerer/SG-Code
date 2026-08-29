module "internet_gateway" {
  source   = "./modules/internet_gateway"
  for_each = var.internet_gateways

  vpc_id = each.value.vpc_id
  tags   = each.value.tags
}
