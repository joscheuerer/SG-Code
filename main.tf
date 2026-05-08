module "iam_role" {
  source               = "./modules/iam_role"
  name                 = var.iam_role_name
  assume_role_policy   = var.iam_role_assume_role_policy
  description          = var.iam_role_description
  path                 = var.iam_role_path
  max_session_duration = var.iam_role_max_session_duration
  attached_policy_arns = var.iam_role_attached_policy_arns
}

module "eks_cluster" {
  source                    = "./modules/eks_cluster"
  name                      = var.eks_cluster_name
  role_arn                  = module.iam_role.arn
  cluster_version           = var.eks_cluster_version
  enabled_cluster_log_types = var.eks_cluster_enabled_log_types
  authentication_mode       = var.eks_cluster_authentication_mode
  subnet_ids                = var.eks_cluster_subnet_ids
  endpoint_private_access   = var.eks_cluster_endpoint_private_access
  endpoint_public_access    = var.eks_cluster_endpoint_public_access
  public_access_cidrs       = var.eks_cluster_public_access_cidrs
  service_ipv4_cidr         = var.eks_cluster_service_ipv4_cidr
  ip_family                 = var.eks_cluster_ip_family
}

module "s3_bucket" {
  source  = "./modules/s3_bucket"
  bucket  = var.s3_bucket_name
  tags    = var.s3_bucket_tags
}