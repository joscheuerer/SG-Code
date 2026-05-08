variable "name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "role_arn" {
  type        = string
  description = "ARN of the IAM role for the EKS control plane"
}

variable "cluster_version" {
  type        = string
  description = "Desired Kubernetes version"
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "List of control plane log types to enable"
  default     = []
}

variable "authentication_mode" {
  type        = string
  description = "Authentication mode for the cluster (CONFIG_MAP, API, or API_AND_CONFIG_MAP)"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the cluster VPC config"
}

variable "endpoint_private_access" {
  type        = bool
  description = "Whether the EKS private API server endpoint is enabled"
}

variable "endpoint_public_access" {
  type        = bool
  description = "Whether the EKS public API server endpoint is enabled"
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed to access the public API server endpoint"
  default     = []
}

variable "service_ipv4_cidr" {
  type        = string
  description = "CIDR block for Kubernetes service IP addresses"
}

variable "ip_family" {
  type        = string
  description = "IP family for Kubernetes pod and service addresses (ipv4 or ipv6)"
}