# ec2-instance-with-networking

EC2 instance with associated EBS volume, security group, network interface, subnet, and VPC in eu-central-1.

## Stack Overview

This stack provisions a complete EC2 networking environment in AWS region `eu-central-1`, including:

- A VPC with a configurable CIDR block
- A public subnet within the VPC
- A security group allowing SSH ingress
- An EBS volume (gp3) based on a snapshot
- A primary network interface attached to the EC2 instance
- An EC2 instance (t3.medium) with configurable metadata options

## Module Overview

| Module | Description | Source |
|--------|-------------|--------|
| `vpc` | Manages the VPC | `./modules/vpc` |
| `subnet` | Manages the public subnet | `./modules/subnet` |
| `security_group` | Manages the EC2 security group allowing SSH access | `./modules/security_group` |
| `ebs_volume` | Manages the EBS volume attached to the EC2 instance | `./modules/ebs_volume` |
| `network_interface` | Manages the primary network interface attached to the EC2 instance | `./modules/network_interface` |
| `instance` | Manages the EC2 instance | `./modules/instance` |

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | AWS region where resources will be managed | `eu-central-1` |
| `vpc_cidr_block` | `string` | The IPv4 CIDR block for the VPC | `10.0.0.0/16` |
| `vpc_instance_tenancy` | `string` | Tenancy option for instances launched into the VPC | `default` |
| `vpc_tags` | `map(string)` | Tags to assign to the VPC | `{Name="vpc_name"}` |
| `subnet_cidr_block` | `string` | The IPv4 CIDR block for the subnet | `10.0.0.0/24` |
| `subnet_availability_zone` | `string` | AZ for the subnet | `eu-central-1a` |
| `subnet_map_public_ip_on_launch` | `bool` | Whether instances get a public IP | `true` |
| `subnet_assign_ipv6_address_on_creation` | `bool` | Whether network interfaces get an IPv6 address | `false` |
| `subnet_tags` | `map(string)` | Tags to assign to the subnet | `{Name="vpc_name-public-eu-central-1a"}` |
| `security_group_name` | `string` | Name of the security group | `ec2-sg-09a43dgt` |
| `security_group_description` | `string` | Description of the security group | `Security group for EC2 instance - SSH access` |
| `security_group_ingress` | `list(object)` | Ingress rules for the security group | SSH on port 22 |
| `security_group_egress` | `list(object)` | Egress rules for the security group | All outbound |
| `ebs_availability_zone` | `string` | AZ for the EBS volume | `eu-central-1a` |
| `ebs_size` | `number` | Size of the EBS volume in GiB | `20` |
| `ebs_type` | `string` | Type of EBS volume | `gp3` |
| `ebs_iops` | `number` | IOPS for the EBS volume | `3000` |
| `ebs_throughput` | `number` | Throughput in MiB/s | `125` |
| `ebs_encrypted` | `bool` | Whether the EBS volume is encrypted | `false` |
| `ebs_multi_attach_enabled` | `bool` | Whether EBS Multi-Attach is enabled | `false` |
| `ebs_snapshot_id` | `string` | Snapshot ID to base the EBS volume on | `snap-0b0311f5a7890791a` |
| `eni_private_ips` | `list(string)` | Private IPs for the ENI | `["10.0.0.65"]` |
| `eni_source_dest_check` | `bool` | Whether source/dest check is enabled on ENI | `true` |
| `eni_device_index` | `number` | Device index for ENI attachment | `0` |
| `instance_ami` | `string` | AMI ID for the EC2 instance | `ami-03b7a7ce915b46b75` |
| `instance_instance_type` | `string` | EC2 instance type | `t3.medium` |
| `instance_key_name` | `string` | Key pair name | `ec2-key-09a43dgt` |
| `instance_availability_zone` | `string` | AZ for the EC2 instance | `eu-central-1a` |
| `instance_tenancy` | `string` | Tenancy of the instance | `default` |
| `instance_source_dest_check` | `bool` | Source/dest check on instance | `true` |
| `instance_ebs_optimized` | `bool` | Whether instance is EBS-optimized | `false` |
| `instance_monitoring` | `bool` | Whether detailed monitoring is enabled | `false` |
| `instance_metadata_http_endpoint` | `string` | Metadata service availability | `enabled` |
| `instance_metadata_http_protocol_ipv6` | `string` | IPv6 metadata endpoint | `disabled` |
| `instance_metadata_http_put_response_hop_limit` | `number` | Metadata hop limit | `1` |
| `instance_metadata_http_tokens` | `string` | IMDSv2 token requirement | `optional` |
| `instance_metadata_instance_metadata_tags` | `string` | Instance metadata tags access | `disabled` |
| `instance_capacity_reservation_preference` | `string` | Capacity reservation preference | `open` |
| `instance_enclave_options_enabled` | `bool` | Whether Nitro Enclaves are enabled | `false` |
| `instance_root_block_device_delete_on_termination` | `bool` | Delete root volume on termination | `true` |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `vpc_id` | The ID of the VPC |
| `subnet_id` | The ID of the subnet |
| `security_group_id` | The ID of the security group |
| `ebs_volume_id` | The ID of the EBS volume |
| `network_interface_id` | The ID of the network interface |
| `instance_id` | The ID of the EC2 instance |
| `instance_public_ip` | The public IP address of the EC2 instance |
| `instance_private_ip` | The private IP address of the EC2 instance |

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

## Cross-Module Wiring

- `module.subnet` receives `vpc_id` from `module.vpc.vpc_id`
- `module.security_group` receives `vpc_id` from `module.vpc.vpc_id`
- `module.instance` receives `subnet_id` from `module.subnet.subnet_id` and `vpc_security_group_ids` from `module.security_group.security_group_id`
- `module.network_interface` receives `subnet_id` from `module.subnet.subnet_id`, `security_groups` from `module.security_group.security_group_id`, and `attached_instance_id` from `module.instance.instance_id`