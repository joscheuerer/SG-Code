region = "eu-central-1"

iam_role_name                 = "AmazonEKSAutoClusterRole"
iam_role_assume_role_policy   = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"eks.amazonaws.com\"},\"Action\":[\"sts:AssumeRole\",\"sts:TagSession\"]}]}"
iam_role_description          = "Allows access to other AWS service resources that are required to operate Auto Mode clusters managed by EKS."
iam_role_path                 = "/"
iam_role_max_session_duration = 3600
iam_role_attached_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
  "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy",
  "arn:aws:iam::aws:policy/AmazonEKSComputePolicy",
  "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy",
  "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy",
]

eks_cluster_name                    = "scrumptious-lofi-gopher"
eks_cluster_version                 = "1.35"
eks_cluster_enabled_log_types       = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
eks_cluster_authentication_mode     = "API"
eks_cluster_subnet_ids              = ["subnet-0f0fa8613f4ba368b", "subnet-0b56e5172838f1d91", "subnet-0bb6693f2b6859278"]
eks_cluster_endpoint_private_access = true
eks_cluster_endpoint_public_access  = true
eks_cluster_public_access_cidrs     = ["0.0.0.0/0"]
eks_cluster_service_ipv4_cidr       = "172.20.0.0/16"
eks_cluster_ip_family               = "ipv4"

s3_bucket_name = "test-new-2026"
s3_bucket_tags = {
  Name = "test-new-2026"
}