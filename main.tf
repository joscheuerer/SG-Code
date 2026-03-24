module "vpc" {
  source = "./modules/vpc"

  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "do_not_delete"
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
    Name = "do_not_delete"
  }
}

module "route_tables" {
  source = "./modules/route_table"

  vpc_id                   = module.vpc.vpc_id
  route_tables             = var.route_tables
  routes                   = var.routes
  route_table_associations = var.route_table_associations
}

module "security_group" {
  source = "./modules/security_group"

  description = "default VPC security group"
  name        = "default"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name = "do_not_delete-default"
  }
}

module "network_acl" {
  source = "./modules/network_acl"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = var.network_acl_subnet_ids
  tags = {
    Name = "do_not_delete-default"
  }
  acl_rules = var.network_acl_rules
}