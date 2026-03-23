module "vpc" {
  source = "./modules/vpc"

  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "sg-vpc-xxklkl"
  }
}

module "subnets" {
  source = "./modules/subnet"

  vpc_id = module.vpc.vpc_id
  subnets = {
    sg_vpc_xxklkl_public_eu_central_1a = {
      cidr_block              = "10.0.1.0/24"
      availability_zone       = "eu-central-1a"
      map_public_ip_on_launch = true
      tags = {
        Name = "sg-vpc-xxklkl-public-eu-central-1a"
      }
    }
    sg_vpc_xxklkl_public_eu_central_1b = {
      cidr_block              = "10.0.2.0/24"
      availability_zone       = "eu-central-1b"
      map_public_ip_on_launch = true
      tags = {
        Name = "sg-vpc-xxklkl-public-eu-central-1b"
      }
    }
    sg_vpc_xxklkl_private_eu_central_1a = {
      cidr_block              = "10.0.110.0/24"
      availability_zone       = "eu-central-1a"
      map_public_ip_on_launch = false
      tags = {
        Name = "sg-vpc-xxklkl-private-eu-central-1a"
      }
    }
    sg_vpc_xxklkl_private_eu_central_1b = {
      cidr_block              = "10.0.120.0/24"
      availability_zone       = "eu-central-1b"
      map_public_ip_on_launch = false
      tags = {
        Name = "sg-vpc-xxklkl-private-eu-central-1b"
      }
    }
  }
}

module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "sg-vpc-xxklkl"
  }
}

module "route_tables" {
  source = "./modules/route_table"

  vpc_id = module.vpc.vpc_id
  route_tables = {
    sg_vpc_xxklkl_private_eu_central_1b = {
      tags = {
        Name = "sg-vpc-xxklkl-private-eu-central-1b"
      }
    }
    sg_vpc_xxklkl_private_eu_central_1a = {
      tags = {
        Name = "sg-vpc-xxklkl-private-eu-central-1a"
      }
    }
    sg_vpc_xxklkl_default = {
      tags = {
        Name = "sg-vpc-xxklkl-default"
      }
    }
    sg_vpc_xxklkl_public = {
      tags = {
        Name = "sg-vpc-xxklkl-public"
      }
    }
  }
  routes = {
    public_internet = {
      route_table_key        = "sg_vpc_xxklkl_public"
      destination_cidr_block = "0.0.0.0/0"
      gateway_id             = module.internet_gateway.internet_gateway_id
    }
  }
  route_table_associations = {
    private_1b = {
      route_table_key = "sg_vpc_xxklkl_private_eu_central_1b"
      subnet_id       = module.subnets.subnet_ids["sg_vpc_xxklkl_private_eu_central_1b"]
    }
    private_1a = {
      route_table_key = "sg_vpc_xxklkl_private_eu_central_1a"
      subnet_id       = module.subnets.subnet_ids["sg_vpc_xxklkl_private_eu_central_1a"]
    }
    public_1a = {
      route_table_key = "sg_vpc_xxklkl_public"
      subnet_id       = module.subnets.subnet_ids["sg_vpc_xxklkl_public_eu_central_1a"]
    }
    public_1b = {
      route_table_key = "sg_vpc_xxklkl_public"
      subnet_id       = module.subnets.subnet_ids["sg_vpc_xxklkl_public_eu_central_1b"]
    }
  }
}

module "security_groups" {
  source = "./modules/security_group"

  vpc_id = module.vpc.vpc_id
  security_groups = {
    default = {
      name        = "default"
      description = "default VPC security group"
      tags = {
        Name = "sg-vpc-xxklkl-default"
      }
    }
    vpc_092e2c24e01e5e088_20251126171749264400000001 = {
      name        = "vpc-092e2c24e01e5e088-20251126171749264400000001"
      description = "Security Group managed by Terraform"
      tags = {
        Name = "vpc-092e2c24e01e5e088"
      }
    }
  }
  security_group_rules = {
    http_ingress = {
      security_group_key = "vpc_092e2c24e01e5e088_20251126171749264400000001"
      type               = "ingress"
      from_port          = 80
      to_port            = 80
      protocol           = "tcp"
      cidr_blocks        = ["0.0.0.0/0"]
      description        = "http"
    }
    ssh_ingress = {
      security_group_key = "vpc_092e2c24e01e5e088_20251126171749264400000001"
      type               = "ingress"
      from_port          = 22
      to_port            = 22
      protocol           = "tcp"
      cidr_blocks        = ["0.0.0.0/0"]
      description        = "ssh"
    }
    all_egress = {
      security_group_key = "vpc_092e2c24e01e5e088_20251126171749264400000001"
      type               = "egress"
      from_port          = 0
      to_port            = 0
      protocol           = "-1"
      cidr_blocks        = ["0.0.0.0/0"]
      description        = "All outgoing traffic allowed"
    }
  }
}

module "network_acl" {
  source = "./modules/network_acl"

  vpc_id = module.vpc.vpc_id
  network_acl_rules = {
    egress_100 = {
      rule_number = 100
      egress      = true
      protocol    = "-1"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
    }
    egress_32767 = {
      rule_number = 32767
      egress      = true
      protocol    = "-1"
      rule_action = "deny"
      cidr_block  = "0.0.0.0/0"
    }
    ingress_100 = {
      rule_number = 100
      egress      = false
      protocol    = "-1"
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
    }
    ingress_32767 = {
      rule_number = 32767
      egress      = false
      protocol    = "-1"
      rule_action = "deny"
      cidr_block  = "0.0.0.0/0"
    }
  }
}