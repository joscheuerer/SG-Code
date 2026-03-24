region = "eu-central-1"

subnets = {
  subnetname1 = {
    cidr_block              = "10.0.10.0/24"
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = false
    tags = {
      Name = "subnetname1"
    }
  }
  subnetname2 = {
    cidr_block              = "10.0.20.0/24"
    availability_zone       = "eu-central-1b"
    map_public_ip_on_launch = false
    tags = {
      Name = "subnetname2"
    }
  }
  privatesubnetname1 = {
    cidr_block              = "10.0.110.0/24"
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = false
    tags = {
      Name = "privatesubnetname1"
    }
  }
  privatesubnetname2 = {
    cidr_block              = "10.0.120.0/24"
    availability_zone       = "eu-central-1b"
    map_public_ip_on_launch = false
    tags = {
      Name = "privatesubnetname2"
    }
  }
}

route_tables = {
  do_not_delete_public = {
    tags = {
      Name = "do_not_delete-public"
    }
  }
  do_not_delete_default = {
    tags = {
      Name = "do_not_delete-default"
    }
  }
  do_not_delete_private_eu_central_1a = {
    tags = {
      Name = "do_not_delete-private-eu-central-1a"
    }
  }
  do_not_delete_private_eu_central_1b = {
    tags = {
      Name = "do_not_delete-private-eu-central-1b"
    }
  }
}

routes = {
  public_internet = {
    route_table_key        = "do_not_delete_public"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "igw-081452c458c193e5e"
  }
}

route_table_associations = {
  public_subnetname1 = {
    route_table_key = "do_not_delete_public"
    subnet_id       = "subnet-0587478b1e052ce6a"
  }
  public_subnetname2 = {
    route_table_key = "do_not_delete_public"
    subnet_id       = "subnet-03a230a9d1b8b9036"
  }
  private_privatesubnetname1 = {
    route_table_key = "do_not_delete_private_eu_central_1a"
    subnet_id       = "subnet-0e4b2d1e5907c198e"
  }
  private_privatesubnetname2 = {
    route_table_key = "do_not_delete_private_eu_central_1b"
    subnet_id       = "subnet-0fedab5812fadb197"
  }
}

network_acl_subnet_ids = [
  "subnet-0587478b1e052ce6a",
  "subnet-03a230a9d1b8b9036",
  "subnet-0e4b2d1e5907c198e",
  "subnet-0fedab5812fadb197"
]

network_acl_rules = {
  egress_100 = {
    rule_number     = 100
    egress          = true
    protocol        = "-1"
    rule_action     = "allow"
    cidr_block      = "0.0.0.0/0"
    ipv6_cidr_block = null
  }
  egress_101 = {
    rule_number     = 101
    egress          = true
    protocol        = "-1"
    rule_action     = "allow"
    cidr_block      = null
    ipv6_cidr_block = "::/0"
  }
  ingress_100 = {
    rule_number     = 100
    egress          = false
    protocol        = "-1"
    rule_action     = "allow"
    cidr_block      = "0.0.0.0/0"
    ipv6_cidr_block = null
  }
  ingress_101 = {
    rule_number     = 101
    egress          = false
    protocol        = "-1"
    rule_action     = "allow"
    cidr_block      = null
    ipv6_cidr_block = "::/0"
  }
}