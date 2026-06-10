module "vpc" {
  source = "./modules/vpc"

  cidr_block       = var.vpc.cidr_block
  instance_tenancy = var.vpc.instance_tenancy
  tags             = var.vpc.tags
}

module "subnet" {
  source   = "./modules/subnet"
  for_each = var.subnets

  vpc_id                  = module.vpc.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  tags                    = each.value.tags
}

module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc.vpc_id
  tags   = var.internet_gateway.tags
}

module "route_table" {
  source   = "./modules/route_table"
  for_each = var.route_tables

  vpc_id = module.vpc.vpc_id
  routes = each.value.routes
  tags   = each.value.tags

  internet_gateway_id = module.internet_gateway.internet_gateway_id
}

module "security_group" {
  source   = "./modules/security_group"
  for_each = var.security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = module.vpc.vpc_id
  ingress     = each.value.ingress
  egress      = each.value.egress
  tags        = each.value.tags
}

module "network_acl" {
  source   = "./modules/network_acl"
  for_each = var.network_acls

  default_network_acl_id = each.value.default_network_acl_id
  subnet_ids             = [for s in each.value.subnet_keys : module.subnet[s].subnet_id]
  ingress                = each.value.ingress
  egress                 = each.value.egress
  tags                   = each.value.tags
}

module "key_pair" {
  source   = "./modules/key_pair"
  for_each = var.key_pairs

  key_name   = each.value.key_name
  public_key = each.value.public_key
  tags       = each.value.tags
}
