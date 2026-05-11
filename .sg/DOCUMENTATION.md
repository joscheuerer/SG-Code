# private-runner-infrastructure

## Description

EC2 private runner instance with IAM instance profile and key pair. This stack provisions a private EC2 runner instance in the `eu-central-1` region, along with its associated IAM instance profile and EC2 key pair.

## Architecture

```
key_pair (aws_key_pair)
    └── used by → instance (aws_instance)

iam_instance_profile (aws_iam_instance_profile)
    └── attached to → instance (aws_instance)

instance (aws_instance)
    ├── key_name        ← module.key_pair.key_name
    └── iam_instance_profile ← module.iam_instance_profile.name
```

## Module Overview

| Module | Description | Primary Resource |
|--------|-------------|-----------------|
| `key_pair` | Manages the EC2 key pair for the private runner | `aws_key_pair` |
| `iam_instance_profile` | Manages the IAM instance profile for the EC2 private runner | `aws_iam_instance_profile` |
| `instance` | Manages the EC2 private runner instance | `aws_instance` |

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | AWS region to deploy resources in | `eu-central-1` |
| `key_pair_key_name` | `string` | Name of the EC2 key pair | `private-runner-workshop` |
| `key_pair_public_key` | `string` | Public key material (sensitive) | `""` |
| `iam_instance_profile_name` | `string` | Name of the IAM instance profile | `ec2_private_runner_role` |
| `iam_instance_profile_path` | `string` | Path for the IAM instance profile | `/` |
| `iam_instance_profile_role` | `string` | IAM role name to associate | `ec2_private_runner_role` |
| `instance_ami` | `string` | AMI ID for the EC2 instance | `ami-04f9a173520f395dd` |
| `instance_instance_type` | `string` | EC2 instance type | `t2.large` |
| `instance_availability_zone` | `string` | Availability zone | `eu-central-1a` |
| `instance_subnet_id` | `string` | Subnet ID | `subnet-064f42dced8666a63` |
| `instance_vpc_security_group_ids` | `list(string)` | Security group IDs | `["sg-0adb3e09fe11a19a1"]` |
| `instance_source_dest_check` | `bool` | Enable source/destination check | `true` |
| `instance_ebs_optimized` | `bool` | EBS optimized | `false` |
| `instance_monitoring` | `bool` | Detailed monitoring | `false` |
| `instance_tenancy` | `string` | Instance tenancy | `default` |
| `instance_capacity_reservation_preference` | `string` | Capacity reservation preference | `open` |
| `instance_cpu_core_count` | `number` | CPU core count | `2` |
| `instance_cpu_threads_per_core` | `number` | Threads per CPU core | `1` |
| `instance_metadata_http_endpoint` | `string` | Metadata HTTP endpoint | `enabled` |
| `instance_metadata_http_protocol_ipv6` | `string` | Metadata IPv6 protocol | `disabled` |
| `instance_metadata_http_put_response_hop_limit` | `number` | Metadata hop limit | `2` |
| `instance_metadata_http_tokens` | `string` | IMDSv2 token requirement | `required` |
| `instance_metadata_instance_metadata_tags` | `string` | Instance metadata tags | `disabled` |
| `instance_enclave_options_enabled` | `bool` | Nitro Enclaves enabled | `false` |
| `instance_root_block_device_delete_on_termination` | `bool` | Delete root volume on termination | `true` |
| `instance_tags` | `map(string)` | Tags for the EC2 instance | `{App="Sun", Name="private-runner-do-not-delete"}` |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `instance_id` | ID of the EC2 instance |
| `instance_arn` | ARN of the EC2 instance |
| `instance_private_ip` | Private IP address of the EC2 instance |
| `instance_public_ip` | Public IP address of the EC2 instance |
| `iam_instance_profile_arn` | ARN of the IAM instance profile |
| `key_pair_key_name` | Name of the EC2 key pair |

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

### 3. Plan

```sh
terraform plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```

## Notes

- The `key_pair_public_key` variable is sensitive. Provide the actual public key value before running `terraform apply` if managing the key pair's public key.
- The EC2 instance (`i-08663188cc77a9249`) is tagged `private-runner-do-not-delete` — exercise caution before destroying.
- Import must be run before plan/apply to avoid resource recreation.