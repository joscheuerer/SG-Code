region               = "eu-central-1"
vpc_cidr_block       = "10.0.0.0/16"
vpc_instance_tenancy = "default"
vpc_tags = {
  Name = "basic-eks"
}

subnets = {
  basic_eks_public_eu_central_1b = {
    cidr_block                      = "10.0.101.0/24"
    availability_zone               = "eu-central-1b"
    map_public_ip_on_launch         = false
    assign_ipv6_address_on_creation = false
    tags = {
      "kubernetes.io/role/elb" = "1"
      Name                     = "basic-eks-public-eu-central-1b"
    }
  }
  basic_eks_private_eu_central_1b = {
    cidr_block                      = "10.0.1.0/24"
    availability_zone               = "eu-central-1b"
    map_public_ip_on_launch         = false
    assign_ipv6_address_on_creation = false
    tags = {
      "kubernetes.io/role/internal-elb" = "1"
      Name                              = "basic-eks-private-eu-central-1b"
    }
  }
  basic_eks_public_eu_central_1a = {
    cidr_block                      = "10.0.100.0/24"
    availability_zone               = "eu-central-1a"
    map_public_ip_on_launch         = false
    assign_ipv6_address_on_creation = false
    tags = {
      "kubernetes.io/role/elb" = "1"
      Name                     = "basic-eks-public-eu-central-1a"
    }
  }
  basic_eks_private_eu_central_1c = {
    cidr_block                      = "10.0.2.0/24"
    availability_zone               = "eu-central-1c"
    map_public_ip_on_launch         = false
    assign_ipv6_address_on_creation = false
    tags = {
      "kubernetes.io/role/internal-elb" = "1"
      Name                              = "basic-eks-private-eu-central-1c"
    }
  }
  basic_eks_public_eu_central_1c = {
    cidr_block                      = "10.0.102.0/24"
    availability_zone               = "eu-central-1c"
    map_public_ip_on_launch         = false
    assign_ipv6_address_on_creation = false
    tags = {
      "kubernetes.io/role/elb" = "1"
      Name                     = "basic-eks-public-eu-central-1c"
    }
  }
  basic_eks_private_eu_central_1a = {
    cidr_block                      = "10.0.0.0/24"
    availability_zone               = "eu-central-1a"
    map_public_ip_on_launch         = false
    assign_ipv6_address_on_creation = false
    tags = {
      "kubernetes.io/role/internal-elb" = "1"
      Name                              = "basic-eks-private-eu-central-1a"
    }
  }
}

internet_gateway_tags = {
  Name = "basic-eks"
}

route_tables = {
  basic_eks_private = {
    routes = [
      {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = "nat-085a03c3986e2d06d"
      }
    ]
    tags = {
      Name = "basic-eks-private"
    }
  }
  basic_eks_public = {
    routes = [
      {
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw-002f3e748d6007f83"
      }
    ]
    tags = {
      Name = "basic-eks-public"
    }
  }
  basic_eks_default = {
    routes = []
    tags = {
      Name = "basic-eks-default"
    }
  }
}

security_groups = {
  basic_eks_cluster = {
    name        = "basic-eks-cluster-20250805072828562900000004"
    description = "EKS cluster security group"
    ingress = [
      {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        security_groups = ["sg-0259cfa48eae0addd"]
        description     = "Node groups to cluster API"
      }
    ]
    egress = []
    tags = {
      Name = "basic-eks-cluster"
    }
  }
  outpost = {
    name        = "outpost"
    description = "Outpost instances - outbound only (Tailscale for inbound)"
    ingress     = []
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
  basic_eks_node = {
    name        = "basic-eks-node-20250805072828562600000003"
    description = "EKS node shared security group"
    ingress = [
      {
        from_port       = 6443
        to_port         = 6443
        protocol        = "tcp"
        security_groups = ["sg-011664c0def65d446"]
        description     = "Cluster API to node 6443/tcp webhook"
      },
      {
        from_port       = 9443
        to_port         = 9443
        protocol        = "tcp"
        security_groups = ["sg-011664c0def65d446"]
        description     = "Cluster API to node 9443/tcp webhook"
      },
      {
        from_port   = 1025
        to_port     = 65535
        protocol    = "tcp"
        self        = true
        description = "Node to node ingress on ephemeral ports"
      },
      {
        from_port       = 8443
        to_port         = 8443
        protocol        = "tcp"
        security_groups = ["sg-011664c0def65d446"]
        description     = "Cluster API to node 8443/tcp webhook"
      },
      {
        from_port       = 10250
        to_port         = 10250
        protocol        = "tcp"
        security_groups = ["sg-011664c0def65d446"]
        description     = "Cluster API to node kubelets"
      },
      {
        from_port   = 53
        to_port     = 53
        protocol    = "tcp"
        self        = true
        description = "Node to node CoreDNS"
      },
      {
        from_port   = 53
        to_port     = 53
        protocol    = "udp"
        self        = true
        description = "Node to node CoreDNS UDP"
      },
      {
        from_port       = 4443
        to_port         = 4443
        protocol        = "tcp"
        security_groups = ["sg-011664c0def65d446"]
        description     = "Cluster API to node 4443/tcp webhook"
      },
      {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        security_groups = ["sg-011664c0def65d446"]
        description     = "Cluster API to node groups"
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all egress"
      }
    ]
    tags = {
      "kubernetes.io/cluster/basic-eks" = "owned"
      Name                              = "basic-eks-node"
    }
  }
  default = {
    name        = "default"
    description = "default VPC security group"
    ingress     = []
    egress      = []
    tags = {
      Name = "basic-eks-default"
    }
  }
}

network_acl_egress = [
  {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  },
  {
    rule_no         = 101
    action          = "allow"
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
    from_port       = 0
    to_port         = 0
  }
]

network_acl_ingress = [
  {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  },
  {
    rule_no         = 101
    action          = "allow"
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
    from_port       = 0
    to_port         = 0
  }
]

network_acl_tags = {
  Name = "basic-eks-default"
}