region = "eu-west-2"

name = "vpc-eks"

create_vpc = false

create_igw = true

create_egress_only_igw = false

enable_nat_gateway = false

create_flow_log_cloudwatch_iam_role = false

create_flow_log_cloudwatch_log_group = false

igw_tags = {
  "kubernetes.io/cluster/live-eks-cl2" = "shared"
  "Description"                        = "EKS - VPC"
  "ManagedBy"                          = "Terraform"
  "Cluster"                            = "live-eks-cl2"
  "Environment"                        = "live"
  "Region"                             = "eu-west-2"
  "Name"                               = "vpc-eks"
}

tags = {
  "kubernetes.io/cluster/live-eks-cl2" = "shared"
  "Description"                        = "EKS - VPC"
  "ManagedBy"                          = "Terraform"
  "Cluster"                            = "live-eks-cl2"
  "Environment"                        = "live"
  "Region"                             = "eu-west-2"
  "Name"                               = "vpc-eks"
}