module "vpc_eks" {
  source = "git::https://github.com/StackGuardian/terraform-aws-vpc.git?ref=master"

  name                                  = var.name
  create_vpc                            = var.create_vpc
  create_igw                            = var.create_igw
  create_egress_only_igw                = var.create_egress_only_igw
  enable_nat_gateway                    = var.enable_nat_gateway
  create_flow_log_cloudwatch_iam_role   = var.create_flow_log_cloudwatch_iam_role
  create_flow_log_cloudwatch_log_group  = var.create_flow_log_cloudwatch_log_group
  igw_tags                              = var.igw_tags
  tags                                  = var.tags
}