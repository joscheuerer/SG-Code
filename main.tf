module "vpc" {
  source = "./modules/vpc"

  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "sg-vpc-jkdsbfkjdsabv"
  }
}

module "subnet_private_1b" {
  source = "./modules/subnet"

  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.120.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "sg-vpc-jkdsbfkjdsabv-private-eu-central-1b"
  }
}

module "route_table_private_1b" {
  source = "./modules/route_table"

  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "sg-vpc-jkdsbfkjdsabv-private-eu-central-1b"
  }
  subnet_associations = {
    private_1b = {
      subnet_id = module.subnet_private_1b.subnet_id
    }
  }
}

module "network_acl" {
  source = "./modules/network_acl"

  default_network_acl_id = var.default_network_acl_id
  ingress_rules = [
    {
      protocol   = "-1"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    },
    {
      protocol   = "-1"
      rule_no    = 32767
      action     = "deny"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]
  egress_rules = [
    {
      protocol   = "-1"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    },
    {
      protocol   = "-1"
      rule_no    = 32767
      action     = "deny"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]
}