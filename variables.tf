variable "region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "iam_role_name" {
  type        = string
  description = "Friendly name of the IAM role"
}

variable "iam_role_assume_role_policy" {
  type        = string
  description = "Policy document granting permission to assume the role (JSON string)"
}

variable "iam_role_description" {
  type        = string
  description = "Description of the IAM role"
}

variable "iam_role_path" {
  type        = string
  description = "Path to the IAM role"
}

variable "iam_role_max_session_duration" {
  type        = number
  description = "Maximum session duration in seconds for the IAM role"
}

variable "iam_role_attached_policy_arns" {
  type        = set(string)
  description = "Set of managed policy ARNs to attach to the IAM role"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "eks_cluster_version" {
  type        = string
  description = "Desired Kubernetes version for the EKS cluster"
}

variable "eks_cluster_enabled_log_types" {
  type        = list(string)
  description = "List of control plane log types to enable"
}

variable "eks_cluster_authentication_mode" {
  type        = string
  description = "Authentication mode for the EKS cluster"
}

variable "eks_cluster_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the EKS cluster VPC config"
}

variable "eks_cluster_endpoint_private_access" {
  type        = bool
  description = "Whether the EKS private API server endpoint is enabled"
}

variable "eks_cluster_endpoint_public_access" {
  type        = bool
  description = "Whether the EKS public API server endpoint is enabled"
}

variable "eks_cluster_public_access_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed to access the public API server endpoint"
}

variable "eks_cluster_service_ipv4_cidr" {
  type        = string
  description = "CIDR block for Kubernetes service IP addresses"
}

variable "eks_cluster_ip_family" {
  type        = string
  description = "IP family for Kubernetes pod and service addresses (ipv4 or ipv6)"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "s3_bucket_tags" {
  type        = map(string)
  description = "Tags to assign to the S3 bucket"
}