# private-runner-infrastructure

## Description

EC2 private runner instance with IAM instance profile and key pair in eu-central-1.

This stack provisions and manages:
- An EC2 instance used as a private runner
- An IAM instance profile attached to the EC2 instance
- An EC2 key pair for SSH access to the instance

## Module Overview

| Module | Description |
|--------|-------------|
| `iam_instance_profile` | Manages the IAM instance profile for the EC2 private runner |
| `key_pair` | Manages the EC2 key pair for the private runner |
| `instance` | Manages the EC2 private runner instance |

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | AWS region to deploy resources in | `"eu-central-1"` |
| `iam_instance_profile_name` | `string` | Name of the IAM instance profile | `"ec2_private_runner_role"` |
| `iam_instance_profile_path` | `string` | Path for the IAM instance profile | `"/"` |
| `iam_instance_profile_role` | `string` | Name of the IAM role to associate with the instance profile | `"ec2_private_runner_role"` |
| `key_pair_key_name` | `string` | Name of the EC2 key pair | `"private-runner-workshop"` |
| `key_pair_public_key` | `string` | Public key material for the EC2 key pair (sensitive) | `""` |
| `instance_ami` | `string` | AMI ID to use for the EC2 instance | `"ami-04f9a173520f395dd"` |
| `instance_instance_type` | `string` | EC2 instance type | `"t2.large"` |
| `instance_availability_zone` | `string` | Availability zone to launch the instance in | `"eu-central-1a"` |
| `instance_subnet_id` | `string` | Subnet ID to launch the instance in | `"subnet-064f42dced8666a63"` |
| `instance_vpc_security_group_ids` | `list(string)` | List of security group IDs to associate with the instance | `["sg-0adb3e09fe11a19a1"]` |
| `instance_source_dest_check` | `bool` | Whether to enable source/destination check | `true` |
| `instance_ebs_optimized` | `bool` | Whether the instance is EBS optimized | `false` |
| `instance_monitoring` | `bool` | Whether detailed monitoring is enabled | `false` |
| `instance_tenancy` | `string` | Tenancy of the instance | `"default"` |
| `instance_capacity_reservation_preference` | `string` | Capacity reservation preference for the instance | `"open"` |
| `instance_cpu_core_count` | `number` | Number of CPU cores | `2` |
| `instance_cpu_threads_per_core` | `number` | Number of threads per CPU core | `1` |
| `instance_metadata_http_endpoint` | `string` | Whether the metadata service HTTP endpoint is enabled | `"enabled"` |
| `instance_metadata_http_protocol_ipv6` | `string` | Whether the IPv6 metadata endpoint is enabled | `"disabled"` |
| `instance_metadata_http_put_response_hop_limit` | `number` | HTTP PUT response hop limit for instance metadata requests | `2` |
| `instance_metadata_http_tokens` | `string` | Whether IMDSv2 tokens are required | `"required"` |
| `instance_metadata_instance_metadata_tags` | `string` | Whether instance metadata tags are enabled | `"disabled"` |
| `instance_enclave_options_enabled` | `bool` | Whether Nitro Enclaves are enabled | `false` |
| `instance_root_block_device_delete_on_termination` | `bool` | Whether the root block device is deleted on instance termination | `true` |
| `instance_tags` | `map(string)` | Tags to assign to the EC2 instance | `{App="Sun", Name="private-runner-do-not-delete"}` |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `instance_id` | ID of the EC2 instance |
| `instance_arn` | ARN of the EC2 instance |
| `instance_private_ip` | Private IP address of the EC2 instance |
| `iam_instance_profile_arn` | ARN of the IAM instance profile |
| `key_pair_key_name` | Name of the EC2 key pair |

## Usage Instructions

### 1. Initialize

```sh
terraform init
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
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```

## Notes

- The `key_pair_public_key` variable is sensitive. Set it via an environment variable or a secrets manager rather than storing it in plain text:
  ```sh
  export TF_VAR_key_pair_public_key="ssh-rsa AAAA..."
  ```
- The AWS provider does not return the public key after import, so `terraform plan` may show a diff for `public_key` on the key pair resource after import. This is a known AWS API limitation.
- The `imports.sh` script accepts the Terraform/OpenTofu binary as its first argument (`$1`), allowing use with both `terraform` and `tofu`.