# packer-instance-stack

## Description

EC2 instance created by Packer with its associated EBS volume, security group, subnet, VPC, and network interface in eu-central-1.

## Stack Overview

This stack provisions and manages the following AWS resources in `eu-central-1`:

| Module | Description | Primary Resource |
|--------|-------------|-----------------|
| `vpc` | Manages the VPC that hosts all resources in this stack | `aws_vpc` |
| `subnet` | Manages the public subnet within the VPC | `aws_subnet` |
| `security_group` | Manages the Packer temporary security group | `aws_security_group` |
| `ebs_volume` | Manages the EBS volume attached to the Packer EC2 instance | `aws_ebs_volume` |
| `instance` | Manages the Packer EC2 instance with its network interface | `aws_instance`, `aws_network_interface` |

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | AWS region to deploy resources | `eu-central-1` |
| `vpc_cidr_block` | `string` | The IPv4 CIDR block for the VPC | `10.0.0.0/16` |
| `vpc_instance_tenancy` | `string` | Tenancy option for instances launched into the VPC | `default` |
| `vpc_enable_dns_support` | `bool` | Whether DNS support is enabled in the VPC | `true` |
| `subnet_cidr_block` | `string` | The IPv4 CIDR block for the subnet | `10.0.0.0/24` |
| `subnet_availability_zone` | `string` | The availability zone for the subnet | `eu-central-1a` |
| `subnet_map_public_ip_on_launch` | `bool` | Whether instances launched in this subnet receive a public IP | `true` |
| `subnet_assign_ipv6_address_on_creation` | `bool` | Whether IPv6 addresses are assigned on instance creation | `false` |
| `security_group_name` | `string` | The name of the security group | `packer_68c879f3-...` |
| `security_group_description` | `string` | Description of the security group | `Temporary group for Packer` |
| `ebs_availability_zone` | `string` | The availability zone for the EBS volume | `eu-central-1a` |
| `ebs_size` | `number` | The size of the EBS volume in GiB | `8` |
| `ebs_type` | `string` | The type of the EBS volume | `gp2` |
| `ebs_iops` | `number` | The IOPS for the EBS volume | `100` |
| `ebs_encrypted` | `bool` | Whether the EBS volume is encrypted | `false` |
| `ebs_multi_attach_enabled` | `bool` | Whether multi-attach is enabled | `false` |
| `ebs_snapshot_id` | `string` | The snapshot ID for the EBS volume | `snap-0baba8406ae0d8928` |
| `instance_ami_id` | `string` | The AMI ID for the EC2 instance | `ami-0242293c1166ee926` |
| `instance_instance_type` | `string` | The EC2 instance type | `t3.medium` |
| `instance_key_name` | `string` | The key pair name for the instance | `packer_68c879f2-...` |
| `instance_vpc_security_group_ids` | `list(string)` | Security group IDs for the instance | `["sg-04211bd5ce13e32c0"]` |
| `instance_availability_zone` | `string` | The availability zone for the instance | `eu-central-1a` |
| `instance_source_dest_check` | `bool` | Whether source/destination checking is enabled | `true` |
| `instance_ebs_optimized` | `bool` | Whether the instance is EBS-optimized | `false` |
| `instance_monitoring` | `bool` | Whether detailed monitoring is enabled | `false` |
| `instance_tenancy` | `string` | The tenancy of the instance | `default` |
| `instance_private_ips` | `list(string)` | Private IPs for the network interface | `["10.0.0.172"]` |

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
# or
tofu init
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
# or
tofu plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
# or
tofu apply -var-file environments/sg.tfvars
```

## Module Dependency Graph

```
vpc
 └── subnet (uses vpc_id)
 └── security_group (uses vpc_id)
      └── instance (uses subnet_id, security_group_ids)
ebs_volume (standalone)
```