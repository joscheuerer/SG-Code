# packer-instance-stack

## Description

Packer EC2 instance with associated EBS volume, security group, subnet, VPC, and network interface in eu-central-1.

This stack manages the full lifecycle of a temporary Packer build environment including networking (VPC, subnet, security group), compute (EC2 instance), storage (EBS volume), and network interface resources.

## Architecture Overview

```
VPC (10.0.0.0/16)
└── Subnet (10.0.0.0/24, eu-central-1a)
    ├── Security Group (Packer temporary SG)
    ├── EC2 Instance (t3.medium, Packer build)
    │   └── Root EBS Volume
    ├── EBS Volume (8 GiB gp2, from snapshot)
    └── Network Interface (ENI, attached to instance)
```

## Module Overview

| Module | Description | Resource Type |
|--------|-------------|---------------|
| `vpc` | Manages the VPC | `aws_vpc` |
| `subnet` | Manages the public subnet in eu-central-1a | `aws_subnet` |
| `security_group` | Manages the Packer temporary security group | `aws_security_group` |
| `ebs_volume` | Manages the EBS volume attached to the Packer instance | `aws_ebs_volume` |
| `instance` | Manages the Packer EC2 instance | `aws_instance` |
| `network_interface` | Manages the primary network interface attached to the Packer instance | `aws_network_interface` |

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | AWS region where resources will be managed | `eu-central-1` |
| `vpc_cidr_block` | `string` | The IPv4 CIDR block for the VPC | `10.0.0.0/16` |
| `vpc_instance_tenancy` | `string` | Tenancy option for instances launched into the VPC | `default` |
| `vpc_tags` | `map(string)` | Tags to assign to the VPC | `{Name="vpc_name"}` |
| `subnet_cidr_block` | `string` | The IPv4 CIDR block for the subnet | `10.0.0.0/24` |
| `subnet_availability_zone` | `string` | AZ for the subnet | `eu-central-1a` |
| `subnet_map_public_ip_on_launch` | `bool` | Whether to assign a public IP to instances launched in this subnet | `true` |
| `subnet_assign_ipv6_address_on_creation` | `bool` | Whether to assign IPv6 addresses on creation | `false` |
| `subnet_tags` | `map(string)` | Tags to assign to the subnet | `{Name="vpc_name-public-eu-central-1a"}` |
| `security_group_name` | `string` | Name of the security group | Packer SG name |
| `security_group_description` | `string` | Description of the security group | `Temporary group for Packer` |
| `security_group_ingress` | `list(object)` | Ingress rules for the security group | SSH from specific IP |
| `security_group_egress` | `list(object)` | Egress rules for the security group | All traffic |
| `ebs_availability_zone` | `string` | Availability zone where the EBS volume will exist | `eu-central-1a` |
| `ebs_size` | `number` | Size of the drive in GiBs | `8` |
| `ebs_type` | `string` | Type of EBS volume | `gp2` |
| `ebs_iops` | `number` | Amount of IOPS to provision for the disk | `100` |
| `ebs_encrypted` | `bool` | Whether the disk will be encrypted | `false` |
| `ebs_multi_attach_enabled` | `bool` | Whether to enable EBS Multi-Attach | `false` |
| `ebs_snapshot_id` | `string` | Snapshot ID to base the EBS volume off of | `snap-0baba8406ae0d8928` |
| `instance_ami` | `string` | AMI to use for the instance | `ami-0242293c1166ee926` |
| `instance_instance_type` | `string` | Instance type to use for the instance | `t3.medium` |
| `instance_key_name` | `string` | Key name of the Key Pair to use for the instance | Packer key pair |
| `instance_availability_zone` | `string` | AZ to start the instance in | `eu-central-1a` |
| `instance_tenancy` | `string` | Tenancy of the instance | `default` |
| `instance_ebs_optimized` | `bool` | Whether the launched EC2 instance will be EBS-optimized | `false` |
| `instance_source_dest_check` | `bool` | Controls if traffic is routed to the instance when the destination address does not match | `true` |
| `instance_monitoring` | `bool` | Whether the launched EC2 instance will have detailed monitoring enabled | `false` |
| `instance_capacity_reservation_preference` | `string` | Indicates the instance's Capacity Reservation preferences | `none` |
| `instance_cpu_core_count` | `number` | Number of CPU cores for the instance | `1` |
| `instance_cpu_threads_per_core` | `number` | Number of threads per CPU core | `2` |
| `instance_enclave_options_enabled` | `bool` | Whether Nitro Enclaves will be enabled on the instance | `false` |
| `instance_metadata_http_endpoint` | `string` | Whether the metadata service is available | `enabled` |
| `instance_metadata_http_protocol_ipv6` | `string` | Whether the IPv6 endpoint for the instance metadata service is enabled | `disabled` |
| `instance_metadata_http_put_response_hop_limit` | `number` | Desired HTTP PUT response hop limit for instance metadata requests | `1` |
| `instance_metadata_http_tokens` | `string` | Whether or not the metadata service requires session tokens | `optional` |
| `instance_metadata_instance_metadata_tags` | `string` | Enables or disables access to instance tags from the instance metadata service | `disabled` |
| `instance_root_block_device_delete_on_termination` | `bool` | Whether the root volume should be destroyed on instance termination | `true` |
| `eni_private_ips` | `list(string)` | List of private IPs to assign to the ENI | `["10.0.0.172"]` |
| `eni_source_dest_check` | `bool` | Whether to enable source destination checking for the ENI | `true` |
| `eni_device_index` | `number` | Integer to define the device index for the attachment | `0` |

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

### 2. Import Existing Resources

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