# private-runner-infrastructure

## Description

EC2 private runner instance with IAM instance profile and key pair in eu-central-1.

This stack provisions and manages:
- An EC2 instance used as a private runner
- An IAM instance profile attached to the EC2 instance
- An AWS key pair for SSH access to the instance

## Module Overview

| Module | Description |
|--------|-------------|
| `iam_instance_profile` | Manages the IAM instance profile for the EC2 private runner |
| `key_pair` | Manages the key pair for the private runner |
| `instance` | Manages the EC2 private runner instance |

## Variables Reference

| Variable | Type | Description |
|----------|------|-------------|
| `region` | `string` | AWS region to deploy resources in |
| `iam_instance_profile_name` | `string` | Name of the IAM instance profile |
| `iam_instance_profile_path` | `string` | Path for the IAM instance profile |
| `iam_instance_profile_role` | `string` | Name of the IAM role to associate with the instance profile |
| `key_pair_key_name` | `string` | Name of the key pair |
| `key_pair_public_key` | `string` | Public key material for the key pair (sensitive) |
| `instance_ami` | `string` | AMI ID to use for the instance |
| `instance_instance_type` | `string` | EC2 instance type |
| `instance_availability_zone` | `string` | Availability zone to launch the instance in |
| `instance_subnet_id` | `string` | Subnet ID to launch the instance in |
| `instance_vpc_security_group_ids` | `list(string)` | List of security group IDs to associate with the instance |
| `instance_source_dest_check` | `bool` | Whether to enable source/destination check |
| `instance_ebs_optimized` | `bool` | Whether the instance is EBS optimized |
| `instance_monitoring` | `bool` | Whether detailed monitoring is enabled |
| `instance_tenancy` | `string` | Tenancy of the instance |
| `instance_capacity_reservation_preference` | `string` | Capacity reservation preference for the instance |
| `instance_cpu_core_count` | `number` | Number of CPU cores |
| `instance_cpu_threads_per_core` | `number` | Number of threads per CPU core |
| `instance_metadata_http_endpoint` | `string` | Whether the metadata service HTTP endpoint is enabled |
| `instance_metadata_http_protocol_ipv6` | `string` | Whether the IPv6 metadata endpoint is enabled |
| `instance_metadata_http_put_response_hop_limit` | `number` | HTTP PUT response hop limit for instance metadata requests |
| `instance_metadata_http_tokens` | `string` | Whether IMDSv2 tokens are required |
| `instance_metadata_instance_metadata_tags` | `string` | Whether instance metadata tags are enabled |
| `instance_enclave_options_enabled` | `bool` | Whether Nitro Enclaves are enabled |
| `instance_root_block_device_delete_on_termination` | `bool` | Whether the root block device is deleted on instance termination |
| `instance_tags` | `map(string)` | Tags to assign to the instance |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `instance_id` | ID of the EC2 instance |
| `instance_arn` | ARN of the EC2 instance |
| `instance_private_ip` | Private IP address of the EC2 instance |
| `iam_instance_profile_arn` | ARN of the IAM instance profile |
| `key_pair_key_name` | Name of the key pair |

## Usage Instructions

### 1. Initialize

```sh
terraform init
# or
tofu init
```

### 2. Import existing resources

```sh
chmod +x imports.sh
./imports.sh terraform
# or for OpenTofu:
./imports.sh tofu
```

### 3. Plan

```sh
terraform plan -var-file environments/sg.tfvars
# or
tofu plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
# or
tofu apply -var-file environments/sg.tfvars
```

> **Note:** The `key_pair_public_key` variable is sensitive. After import, Terraform will attempt to detect drift on the public key. Since the AWS API does not return the public key material, you must supply the correct public key value in your tfvars or via environment variable `TF_VAR_key_pair_public_key` to avoid unintended replacement.