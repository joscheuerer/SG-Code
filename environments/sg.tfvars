vpc = {
  cidr_block       = "10.20.0.0/16"
  instance_tenancy = "default"
  tags = {
    "Project"    = "approvalv2"
    "Enviroment" = "dev2"
    "Name"       = "approvalv2-dev2-vpc"
  }
}

subnets = {
  "approvalv2_dev2_privatesubnet1" = {
    cidr_block              = "10.20.30.0/24"
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = true
    tags = {
      "Project"    = "approvalv2"
      "Enviroment" = "dev2"
      "Name"       = "approvalv2-dev2-PrivateSubnet1"
    }
  }
  "approvalv2_dev2_publicsubnet1" = {
    cidr_block              = "10.20.10.0/24"
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = true
    tags = {
      "Project"    = "approvalv2"
      "Enviroment" = "dev2"
      "Name"       = "approvalv2-dev2-PublicSubnet1"
    }
  }
  "approvalv2_dev2_publicsubnet2" = {
    cidr_block              = "10.20.20.0/24"
    availability_zone       = "eu-central-1b"
    map_public_ip_on_launch = true
    tags = {
      "Project"    = "approvalv2"
      "Enviroment" = "dev2"
      "Name"       = "approvalv2-dev2-PublicSubnet2"
    }
  }
  "approvalv2_dev2_privatesubnet2" = {
    cidr_block              = "10.20.40.0/24"
    availability_zone       = "eu-central-1b"
    map_public_ip_on_launch = true
    tags = {
      "Project"    = "approvalv2"
      "Enviroment" = "dev2"
      "Name"       = "approvalv2-dev2-PrivateSubnet2"
    }
  }
  "approvalv2_dev2_publicsubnet3" = {
    cidr_block              = "10.20.25.0/24"
    availability_zone       = "eu-central-1c"
    map_public_ip_on_launch = true
    tags = {
      "Project"    = "approvalv2"
      "Enviroment" = "dev2"
      "Name"       = "approvalv2-dev2-PublicSubnet3"
    }
  }
}

internet_gateway = {
  tags = {
    "Project"    = "approvalv2"
    "Enviroment" = "dev2"
    "Name"       = "approvalv2-dev2-IGW"
  }
}

route_tables = {
  "approvalv2_dev2_publicrt" = {
    routes = [
      {
        cidr_block = "0.0.0.0/0"
        use_igw    = true
      }
    ]
    tags = {
      "Project"    = "approvalv2"
      "Enviroment" = "dev2"
      "Name"       = "approvalv2-dev2-PublicRT"
    }
  }
  "approvalv2_dev2_privatert" = {
    routes = []
    tags = {
      "Project"    = "approvalv2"
      "Enviroment" = "dev2"
      "Name"       = "approvalv2-dev2-PrivateRT"
    }
  }
  "aws_route_table_2" = {
    routes = []
    tags   = {}
  }
}

security_groups = {
  "approvalv2_dev2_sc1" = {
    name        = "approvalv2-dev2-SC1"
    description = "Allow http, https, and ssh port."
    ingress = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow http traffic."
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow ssh traffic."
      },
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow https traffic."
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Outgoing traffic."
      }
    ]
    tags = {}
  }
  "default" = {
    name        = "default"
    description = "default VPC security group"
    ingress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = []
        self        = true
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    tags = {}
  }
}

# NACL acl-002a010e6f61e9ae6 - rule 32767 dropped (out of valid range 1-32766)
network_acls = {
  "approvalv2_dev2_nacl" = {
    default_network_acl_id = "acl-002a010e6f61e9ae6"
    subnet_keys = [
      "approvalv2_dev2_publicsubnet2",
      "approvalv2_dev2_publicsubnet1",
      "approvalv2_dev2_privatesubnet2",
      "approvalv2_dev2_publicsubnet3",
      "approvalv2_dev2_privatesubnet1"
    ]
    ingress = [
      {
        rule_no    = 100
        action     = "allow"
        protocol   = "-1"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
      }
    ]
    egress = [
      {
        rule_no    = 100
        action     = "allow"
        protocol   = "-1"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
      }
    ]
    tags = {}
  }
}

key_pairs = {
  "ansible_instance_key" = {
    key_name   = "ansible-instance-key"
    public_key = "placeholder"
  }
}
