module "vpc" {
  source = "./modules/vpc"

  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpc-ms"
  }
}

module "subnet" {
  source = "./modules/subnet"

  availability_zone       = "eu-central-1b"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = module.vpc.vpc_id
  tags = {
    Name = "vpc-ms-public-eu-central-1b"
  }
}

module "security_group" {
  source = "./modules/security_group"

  description = "EKS created security group applied to ENI that is attached to EKS Control Plane master nodes, as well as any managed workloads."
  name        = "eks-cluster-sg-eks-ms-1301133594"
  vpc_id      = module.vpc.vpc_id
  tags = {
    "kubernetes.io/cluster/eks-ms" = "owned"
    "aws:eks:cluster-name"         = "eks-ms"
    Name                           = "eks-cluster-sg-eks-ms-1301133594"
  }
  ingress_rules = {
    allow_self = {
      protocol  = "-1"
      from_port = 0
      to_port   = 0
      self      = true
    }
  }
  egress_rules = {
    allow_all = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

module "instance" {
  source = "./modules/instance"

  ami                                      = "ami-027ceff350abb2819"
  availability_zone                        = "eu-central-1b"
  ebs_optimized                            = false
  iam_instance_profile                     = var.iam_instance_profile_arn
  instance_type                            = "t3.medium"
  metadata_http_endpoint                   = "enabled"
  metadata_http_put_response_hop_limit     = 2
  metadata_http_tokens                     = "required"
  monitoring                               = true
  root_volume_delete_on_termination        = true
  root_volume_encrypted                    = false
  root_volume_iops                         = 3000
  root_volume_size                         = 20
  root_volume_throughput                   = 125
  root_volume_type                         = "gp3"
  source_dest_check                        = true
  subnet_id                                = module.subnet.subnet_id
  tenancy                                  = "default"
  vpc_security_group_ids                   = [module.security_group.security_group_id]
  tags = {
    "aws:autoscaling:groupName"      = "eks-managed-node-20260305134536297600000007-fece5f1f-94cc-37f3-cca2-2de45fbc88e4"
    "aws:ec2:fleet-id"               = "fleet-10bd0296-85ae-4ca7-061a-238a12adfc11"
    "k8s.io/cluster-autoscaler/eks-ms" = "owned"
    "kubernetes.io/cluster/eks-ms"   = "owned"
    "aws:eks:cluster-name"           = "eks-ms"
    "eks:cluster-name"               = "eks-ms"
    "aws:ec2launchtemplate:version"  = "1"
    "eks:nodegroup-name"             = "managed-node-20260305134536297600000007"
    "k8s.io/cluster-autoscaler/enabled" = "true"
    "aws:ec2launchtemplate:id"       = "lt-0f9cc5046868cfc14"
    Name                             = "managed-node"
  }
}

module "network_interface" {
  source = "./modules/network_interface"

  description       = "aws-K8S-i-0b86bd1d36a4864dd"
  device_index      = 1
  instance_id       = module.instance.instance_id
  private_ips       = ["10.0.2.210", "10.0.2.68", "10.0.2.53", "10.0.2.44", "10.0.2.29", "10.0.2.143"]
  security_groups   = [module.security_group.security_group_id]
  source_dest_check = true
  subnet_id         = module.subnet.subnet_id
  tags = {
    "eks:eni:owner"                       = "amazon-vpc-cni"
    "node.k8s.amazonaws.com/instance_id"  = "i-0b86bd1d36a4864dd"
    "node.k8s.amazonaws.com/createdAt"    = "2026-03-05T13:47:02Z"
    "cluster.k8s.amazonaws.com/name"      = "eks-ms"
  }
}