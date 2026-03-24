module "vpc" {
  source = "./modules/vpc"

  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "sg-vpc-1109"
  }
}

module "subnets" {
  source = "./modules/subnet"

  vpc_id  = module.vpc.vpc_id
  subnets = var.subnets
}

module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "sg-vpc-1109"
  }
}

module "route_tables" {
  source = "./modules/route_table"

  vpc_id                   = module.vpc.vpc_id
  route_tables             = var.route_tables
  routes                   = var.routes
  route_table_associations = var.route_table_associations
}

module "security_groups" {
  source = "./modules/security_group"

  vpc_id                = module.vpc.vpc_id
  security_groups       = var.security_groups
  security_group_rules  = var.security_group_rules
}

module "network_acl" {
  source = "./modules/network_acl"

  vpc_id = module.vpc.vpc_id
  subnet_ids = [
    module.subnets.subnet_ids["sg_vpc_1109_private_eu_central_1a"],
    module.subnets.subnet_ids["sg_vpc_1109_private_eu_central_1b"],
    module.subnets.subnet_ids["sg_vpc_1109_public_eu_central_1a"],
    module.subnets.subnet_ids["sg_vpc_1109_public_eu_central_1b"]
  ]
  tags      = {}
  acl_rules = var.acl_rules
}