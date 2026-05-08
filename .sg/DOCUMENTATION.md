# eks-cluster-iam-s3-stack

## Description

EKS cluster with IAM role and policy attachments, plus an S3 bucket. Deployed in `eu-central-1`.

## Module Overview

| Module | Description |
|--------|-------------|
| `iam_role` | IAM role for EKS Auto Mode cluster with managed policy attachments |
| `eks_cluster` | EKS cluster with VPC config, access config, logging, and network config |
| `s3_bucket` | S3 bucket with tags |

## Architecture

```
iam_role  ──(role_arn)──►  eks_cluster
    │
    └── aws_iam_role_policy_attachment (×5 managed policies)

s3_bucket  (standalone)
```

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | AWS region to deploy resources | — |
| `iam_role_name` | `string` | Friendly name of the IAM role | — |
| `iam_role_assume_role_policy` | `string` | Assume role policy JSON | — |
| `iam_role_description` | `string` | Description of the IAM role | — |
| `iam_role_path` | `string` | Path to the IAM role | — |
| `iam_role_max_session_duration` | `number` | Max session duration in seconds | — |
| `iam_role_attached_policy_arns` | `set(string)` | Managed policy ARNs to attach | — |
| `eks_cluster_name` | `string` | Name of the EKS cluster | — |
| `eks_cluster_version` | `string` | Desired Kubernetes version | — |
| `eks_cluster_enabled_log_types` | `list(string)` | Control plane log types to enable | — |
| `eks_cluster_authentication_mode` | `string` | Authentication mode (CONFIG_MAP, API, API_AND_CONFIG_MAP) | — |
| `eks_cluster_subnet_ids` | `list(string)` | Subnet IDs for VPC config | — |
| `eks_cluster_endpoint_private_access` | `bool` | Enable private API endpoint | — |
| `eks_cluster_endpoint_public_access` | `bool` | Enable public API endpoint | — |
| `eks_cluster_public_access_cidrs` | `list(string)` | CIDRs for public API access | — |
| `eks_cluster_service_ipv4_cidr` | `string` | CIDR for Kubernetes services | — |
| `eks_cluster_ip_family` | `string` | IP family (ipv4 or ipv6) | — |
| `s3_bucket_name` | `string` | Name of the S3 bucket | — |
| `s3_bucket_tags` | `map(string)` | Tags for the S3 bucket | — |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `iam_role_arn` | ARN of the IAM role |
| `iam_role_name` | Name of the IAM role |
| `eks_cluster_name` | Name of the EKS cluster |
| `eks_cluster_endpoint` | Endpoint of the EKS cluster API server |
| `eks_cluster_arn` | ARN of the EKS cluster |
| `s3_bucket_id` | ID (name) of the S3 bucket |
| `s3_bucket_arn` | ARN of the S3 bucket |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import existing resources

```sh
./imports.sh terraform
# or with OpenTofu:
./imports.sh tofu
```

### 3. Plan (verify zero drift)

```sh
terraform plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```