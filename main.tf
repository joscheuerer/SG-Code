module "vpc" {
  source           = "./modules/vpc"
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.vpc_instance_tenancy
  tags             = var.vpc_tags
}

module "subnet" {
  source                          = "./modules/subnet"
  for_each                        = var.subnets
  vpc_id                          = module.vpc.vpc_id
  cidr_block                      = each.value.cidr_block
  availability_zone               = each.value.availability_zone
  map_public_ip_on_launch         = each.value.map_public_ip_on_launch
  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  tags                            = each.value.tags
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
  tags   = var.internet_gateway_tags
}

module "route_table" {
  source   = "./modules/route_table"
  for_each = var.route_tables
  vpc_id   = module.vpc.vpc_id
  routes   = each.value.routes
  tags     = each.value.tags
}

module "security_group" {
  source      = "./modules/security_group"
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = module.vpc.vpc_id
  ingress     = each.value.ingress
  egress      = each.value.egress
  tags        = each.value.tags
}

module "network_acl" {
  source                 = "./modules/network_acl"
  vpc_id                 = module.vpc.vpc_id
  default_network_acl_id = module.vpc.default_network_acl_id
  subnet_ids = [
    module.subnet["basic_eks_public_eu_central_1b"].subnet_id,
    module.subnet["basic_eks_private_eu_central_1b"].subnet_id,
    module.subnet["basic_eks_public_eu_central_1a"].subnet_id,
    module.subnet["basic_eks_private_eu_central_1c"].subnet_id,
    module.subnet["basic_eks_public_eu_central_1c"].subnet_id,
    module.subnet["basic_eks_private_eu_central_1a"].subnet_id,
  ]
  egress  = var.network_acl_egress
  ingress = var.network_acl_ingress
  tags    = var.network_acl_tags
}