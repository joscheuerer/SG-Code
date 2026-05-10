# Private Runner Infrastructure

## Description

This stack provisions a private runner EC2 instance with all associated infrastructure in `eu-central-1`. It includes a VPC, subnet, security group, key pair, EBS volume, IAM instance profile, and network interface.

## Architecture Overview

```
VPC (10.0.0.0/16)
└── Subnet (10.0.0.0/20, eu-central-1a)
    ├── Security Group (launch-wizard-1, SSH ingress)
    ├── Network Interface (ENI, 10.0.13.161)
    └── EC2 Instance (private-runner-do-not-delete, t2.large)
        ├── Key Pair (private-runner-workshop)
        ├── IAM Instance Profile (ec2_private_runner_role)
        └── EBS Volume (100 GiB gp3, attached separately)
```

## Modules

| Module | Description | Primary Resource |
|--------|-------------|-----------------|
| `vpc` | Manages the private runner VPC | `aws_vpc` |
| `subnet` | Manages the public subnet in eu-central-1a | `aws_subnet` |
| `security_group` | Manages the launch-wizard-1 security group | `aws_security_group` |
| `key_pair` | Manages the private-runner-workshop key pair | `aws_key_pair` |
| `iam_instance_profile` | Manages the ec2_private_runner_role IAM instance profile | `aws_iam_instance_profile` |
| `ebs_volume` | Manages the EBS volume attached to the private runner instance | `aws_ebs_volume` |
| `network_interface` | Manages the ENI attached to the private runner instance | `aws_network_interface` |
| `instance` | Manages the private-runner-do-not-delete EC2 instance | `aws_instance` |

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | AWS region | `eu-central-1` |
| `vpc_cidr_block` | `string` | IPv4 CIDR block for the VPC | `10.0.0.0/16` |
| `vpc_instance_tenancy` | `string` | Tenancy option for VPC instances | `default` |
| `vpc_tags` | `map(string)` | Tags for the VPC | `{Name: private-runner-vpc}` |
| `subnet_cidr_block` | `string` | IPv4 CIDR block for the subnet | `10.0.0.0/20` |
| `subnet_availability_zone` | `string` | AZ for the subnet | `eu-central-1a` |
| `subnet_assign_ipv6_address_on_creation` | `bool` | Assign IPv6 on creation | `false` |
| `subnet_map_public_ip_on_launch` | `bool` | Map public IP on launch | `false` |
| `subnet_tags` | `map(string)` | Tags for the subnet | `{Name: ...}` |
| `security_group_name` | `string` | Security group name | `launch-wizard-1` |
| `security_group_description` | `string` | Security group description | `...` |
| `security_group_ingress` | `list(object)` | Ingress rules | SSH from 0.0.0.0/0 |
| `security_group_egress` | `list(object)` | Egress rules | All traffic |
| `security_group_tags` | `map(string)` | Tags for the security group | `{}` |
| `key_pair_key_name` | `string` | Key pair name | `private-runner-workshop` |
| `key_pair_public_key` | `string` (sensitive) | Public key material | `""` |
| `iam_instance_profile_name` | `string` | Instance profile name | `ec2_private_runner_role` |
| `iam_instance_profile_path` | `string` | Instance profile path | `/` |
| `iam_instance_profile_role` | `string` | IAM role name | `ec2_private_runner_role` |
| `ebs_volume_availability_zone` | `string` | EBS volume AZ | `eu-central-1a` |
| `ebs_volume_size` | `number` | EBS volume size (GiB) | `100` |
| `ebs_volume_type` | `string` | EBS volume type | `gp3` |
| `ebs_volume_iops` | `number` | EBS volume IOPS | `3000` |
| `ebs_volume_throughput` | `number` | EBS volume throughput (MiB/s) | `125` |
| `ebs_volume_encrypted` | `bool` | Whether EBS volume is encrypted | `false` |
| `ebs_volume_multi_attach_enabled` | `bool` | Enable Multi-Attach | `false` |
| `ebs_volume_snapshot_id` | `string` | Snapshot ID for EBS volume | `snap-08c6582254add56c6` |
| `ebs_volume_tags` | `map(string)` | Tags for the EBS volume | `{}` |
| `network_interface_private_ips` | `list(string)` | Private IPs for ENI | `[10.0.13.161]` |
| `network_interface_source_dest_check` | `bool` | Source/dest check for ENI | `true` |
| `network_interface_tags` | `map(string)` | Tags for the ENI | `{}` |
| `instance_ami` | `string` | AMI ID for the instance | `ami-04f9a173520f395dd` |
| `instance_instance_type` | `string` | Instance type | `t2.large` |
| `instance_availability_zone` | `string` | Instance AZ | `eu-central-1a` |
| `instance_source_dest_check` | `bool` | Source/dest check | `true` |
| `instance_ebs_optimized` | `bool` | EBS optimized | `false` |
| `instance_monitoring` | `bool` | Detailed monitoring | `false` |
| `instance_tenancy` | `string` | Instance tenancy | `default` |
| `instance_metadata_http_endpoint` | `string` | Metadata HTTP endpoint | `enabled` |
| `instance_metadata_http_protocol_ipv6` | `string` | Metadata IPv6 protocol | `disabled` |
| `instance_metadata_http_put_response_hop_limit` | `number` | Metadata hop limit | `2` |
| `instance_metadata_http_tokens` | `string` | Metadata token requirement | `required` |
| `instance_metadata_instance_metadata_tags` | `string` | Instance metadata tags access | `disabled` |
| `instance_enclave_options_enabled` | `bool` | Nitro Enclaves enabled | `false` |
| `instance_capacity_reservation_preference` | `string` | Capacity reservation preference | `open` |
| `instance_root_block_device_delete_on_termination` | `bool` | Delete root volume on termination | `true` |
| `instance_root_block_device_volume_size` | `number` | Root volume size (GiB) | `100` |
| `instance_tags` | `map(string)` | Tags for the instance | `{Name: private-runner-do-not-delete}` |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `vpc_id` | The ID of the VPC |
| `subnet_id` | The ID of the subnet |
| `security_group_id` | The ID of the security group |
| `instance_id` | The ID of the EC2 instance |
| `instance_private_ip` | The private IP address of the EC2 instance |
| `ebs_volume_id` | The ID of the EBS volume |
| `network_interface_id` | The ID of the network interface |
| `iam_instance_profile_arn` | The ARN of the IAM instance profile |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import Existing Resources

```sh
bash imports.sh terraform
# or with OpenTofu:
bash imports.sh tofu
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

- The `key_pair_public_key` variable is sensitive. Set it via environment variable or a secrets manager rather than storing it in the tfvars file:
  ```sh
  export TF_VAR_key_pair_public_key="ssh-rsa AAAA..."
  ```
- The EBS volume is managed independently from the instance. Use `aws_volume_attachment` to attach it to the instance if needed.
- The network interface is managed independently. The instance uses `subnet_id` and `vpc_security_group_ids` directly.