region = "eu-central-1"

subnets = {
  sg_vpc_1109_private_eu_central_1b = {
    cidr_block              = "10.0.120.0/24"
    availability_zone       = "eu-central-1b"
    map_public_ip_on_launch = false
    tags = {
      Name = "sg-vpc-1109-private-eu-central-1b"
    }
  }
  sg_vpc_1109_private_eu_central_1a = {
    cidr_block              = "10.0.110.0/24"
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = false
    tags = {
      Name = "sg-vpc-1109-private-eu-central-1a"
    }
  }
  sg_vpc_1109_public_eu_central_1b = {
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "eu-central-1b"
    map_public_ip_on_launch = true
    tags = {
      Name = "sg-vpc-1109-public-eu-central-1b"
    }
  }
  sg_vpc_1109_public_eu_central_1a = {
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "sg-vpc-1109-public-eu-central-1a"
    }
  }
}

route_tables = {
  sg_vpc_1109_private_eu_central_1b = {
    tags = {
      Name = "sg-vpc-1109-private-eu-central-1b"
    }
  }
  sg_vpc_1109_private_eu_central_1a = {
    tags = {
      Name = "sg-vpc-1109-private-eu-central-1a"
    }
  }
  sg_vpc_1109_default = {
    tags = {
      Name = "sg-vpc-1109-default"
    }
  }
  sg_vpc_1109_public = {
    tags = {
      Name = "sg-vpc-1109-public"
    }
  }
}

routes = {
  public_internet = {
    route_table_key        = "sg_vpc_1109_public"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "igw-008fcbf1fab19a62e"
  }
}

route_table_associations = {
  private_1b = {
    route_table_key = "sg_vpc_1109_private_eu_central_1b"
    subnet_id       = "subnet-0036fa55d84835d44"
  }
  private_1a = {
    route_table_key = "sg_vpc_1109_private_eu_central_1a"
    subnet_id       = "subnet-004aea3bfd9cec1da"
  }
  public_1b = {
    route_table_key = "sg_vpc_1109_public"
    subnet_id       = "subnet-066be7ba11f458755"
  }
  public_1a = {
    route_table_key = "sg_vpc_1109_public"
    subnet_id       = "subnet-0b107866a294ad020"
  }
}

security_groups = {
  default = {
    group_name  = "default"
    description = "default VPC security group"
    tags = {
      Name = "sg-vpc-1109-default"
    }
  }
  vpc_09588946e9486d4e3_20250918101256971300000001 = {
    group_name  = "vpc-09588946e9486d4e3-20250918101256971300000001"
    description = "Security Group managed by Terraform"
    tags = {
      Name = "vpc-09588946e9486d4e3"
    }
  }
}

security_group_rules = {
  http_ingress = {
    security_group_key = "vpc_09588946e9486d4e3_20250918101256971300000001"
    type               = "ingress"
    protocol           = "tcp"
    from_port          = 80
    to_port            = 80
    cidr_blocks        = ["0.0.0.0/0"]
    description        = "http"
  }
  ssh_ingress = {
    security_group_key = "vpc_09588946e9486d4e3_20250918101256971300000001"
    type               = "ingress"
    protocol           = "tcp"
    from_port          = 22
    to_port            = 22
    cidr_blocks        = ["0.0.0.0/0"]
    description        = "ssh"
  }
  all_egress = {
    security_group_key = "vpc_09588946e9486d4e3_20250918101256971300000001"
    type               = "egress"
    protocol           = "-1"
    from_port          = 0
    to_port            = 0
    cidr_blocks        = ["0.0.0.0/0"]
    description        = "All outgoing traffic allowed"
  }
}

acl_rules = {
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