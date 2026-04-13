# packer-instance-stack

## Description

Packer EC2 instance with associated EBS volume, security group, subnet, VPC, and network interface in eu-central-1.

This stack manages the full lifecycle of a temporary Packer build environment, including networking (VPC, subnet, security group, ENI) and compute (EC2 instance, EBS volume) resources.

## Module Overview

| Module | Description |
|--------|-------------|
| `vpc` | Manages the VPC (`aws_vpc`) |
| `subnet` | Manages the public subnet in eu-central-1a (`aws_subnet`) |
| `security_group` | Manages the Packer temporary security group (`aws_security_group`) |
| `ebs_volume` | Manages the EBS volume attached to the Packer instance (`aws_ebs_volume`) |
| `instance` | Manages the Packer EC2 instance (`aws_instance`) |
| `network_interface` | Manages the primary ENI attached to the Packer instance (`aws_network_interface`) |

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | AWS region where resources will be managed | `"eu-central-1"` |
| `vpc_cidr_block` | `string` | IPv4 CIDR block for the VPC | `"10.0.0.0/16"` |
| `vpc_instance_tenancy` | `string` | Tenancy option for instances launched into the VPC | `"default"` |
| `vpc_tags` | `map(string)` | Tags to assign to the VPC | `{ Name = "vpc_name" }` |
| `subnet_cidr_block` | `string` | IPv4 CIDR block for the subnet | `"10.0.0.0/24"` |
| `subnet_availability_zone` | `string` | Availability zone for the subnet | `"eu-central-1a"` |
| `subnet_map_public_ip_on_launch` | `bool` | Whether to assign a public IP to instances launched in this subnet | `true` |
| `subnet_assign_ipv6_address_on_creation` | `bool` | Whether to assign IPv6 addresses on creation | `false` |
| `subnet_tags` | `map(string)` | Tags to assign to the subnet | `{ Name = "vpc_name-public-eu-central-1a" }` |
| `security_group_name` | `string` | Name of the security group | `"packer_68c879f3-..."` |
| `security_group_description` | `string` | Description of the security group | `"Temporary group for Packer"` |
| `ebs_volume_availability_zone` | `string` | Availability zone where the EBS volume will exist | `"eu-central-1a"` |
| `ebs_volume_size` | `number` | Size of the EBS volume in GiB | `8` |
| `ebs_volume_type` | `string` | Type of EBS volume | `"gp2"` |
| `ebs_volume_iops` | `number` | Amount of IOPS to provision for the disk | `100` |
| `ebs_volume_encrypted` | `bool` | Whether the disk will be encrypted | `false` |
| `ebs_volume_multi_attach_enabled` | `bool` | Whether to enable EBS Multi-Attach | `false` |
| `ebs_volume_snapshot_id` | `string` | Snapshot ID to base the EBS volume off of | `"snap-0baba8406ae0d8928"` |
| `instance_ami` | `string` | AMI ID to use for the instance | `"ami-0242293c1166ee926"` |
| `instance_instance_type` | `string` | Instance type to use | `"t3.medium"` |
| `instance_key_name` | `string` | Key pair name for the instance | `"packer_68c879f2-..."` |
| `instance_availability_zone` | `string` | Availability zone to start the instance in | `"eu-central-1a"` |
| `instance_source_dest_check` | `bool` | Whether to enable source/destination checking | `true` |
| `instance_ebs_optimized` | `bool` | Whether the instance is EBS-optimized | `false` |
| `instance_monitoring` | `bool` | Whether detailed monitoring is enabled | `false` |
| `instance_tenancy` | `string` | Tenancy of the instance | `"default"` |
| `instance_capacity_reservation_preference` | `string` | Capacity reservation preference for the instance | `"none"` |
| `instance_cpu_core_count` | `number` | Number of CPU cores for the instance | `1` |
| `instance_cpu_threads_per_core` | `number` | Number of threads per CPU core | `2` |
| `instance_enclave_options_enabled` | `bool` | Whether Nitro Enclaves are enabled | `false` |
| `instance_metadata_http_endpoint` | `string` | Whether the metadata service is available | `"enabled"` |
| `instance_metadata_http_protocol_ipv6` | `string` | Whether the IPv6 endpoint for IMDS is enabled | `"disabled"` |
| `instance_metadata_http_put_response_hop_limit` | `number` | HTTP PUT response hop limit | `1` |
| `instance_metadata_http_tokens` | `string` | Whether IMDSv2 session tokens are required | `"optional"` |
| `instance_metadata_instance_metadata_tags` | `string` | Whether access to instance tags from IMDS is enabled | `"disabled"` |
| `instance_root_block_device_delete_on_termination` | `bool` | Whether the root volume is deleted on instance termination | `true` |
| `eni_private_ips` | `list(string)` | Private IP addresses to assign to the ENI | `["10.0.0.172"]` |
| `eni_source_dest_check` | `bool` | Whether to enable source/destination checking for the ENI | `true` |
| `eni_device_index` | `number` | Device index for the ENI attachment | `0` |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `vpc_id` | The ID of the VPC |
| `subnet_id` | The ID of the subnet |
| `security_group_id` | The ID of the security group |
| `ebs_volume_id` | The ID of the EBS volume |
| `instance_id` | The ID of the EC2 instance |
| `network_interface_id` | The ID of the network interface |

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

- The security group allows inbound SSH (port 22) from `178.77.15.22/32` and all outbound traffic.
- The EBS volume is based on snapshot `snap-0baba8406ae0d8928`.
- The ENI is attached to the instance at device index 0.
- All resources are located in `eu-central-1a`.