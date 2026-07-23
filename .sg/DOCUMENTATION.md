# Private Runner Infrastructure

## Stack Description

This stack provisions a private runner VPC with subnets, routing, security groups, network ACL, network interface, EC2 instance, and S3 buckets in `eu-central-1`.

## Module Overview

| Module | Type | Description |
|--------|------|-------------|
| `vpc` | External (`terraform-aws-vpc`) | VPC with public/private subnets, IGW, and route tables |
| `cdk_assets_bucket` | External (`module-tf-aws-s3-bucket`) | CDK assets S3 bucket with versioning and SSE |
| `private_runner_storage_bucket` | External (`module-tf-aws-s3-bucket`) | Private runner storage S3 bucket with SSE |
| `instance` | Local (`./modules/instance`) | EC2 private runner instance with IMDSv2 and metadata options |
| `network_interface` | Local (`./modules/network_interface`) | ENI attached to the private runner instance |
| `security_group_launch_wizard` | Local (`./modules/security_group_launch_wizard`) | Security group with SSH ingress (launch-wizard) |
| `security_group_default` | Local (`./modules/security_group_default`) | Default VPC security group with self-referencing ingress |
| `security_group_launch_wizard_1` | Local (`./modules/security_group_launch_wizard_1`) | Security group with SSH ingress (launch-wizard-1) |
| `network_acl` | Local (`./modules/network_acl`) | Default network ACL associated with both subnets |

## Variables Reference

| Variable | Type | Description |
|----------|------|-------------|
| `region` | `string` | AWS region |
| `vpc_name` | `string` | Name for the VPC |
| `vpc_cidr` | `string` | CIDR block for the VPC |
| `vpc_instance_tenancy` | `string` | Instance tenancy for the VPC |
| `azs` | `list(string)` | Availability zones |
| `public_subnets` | `list(string)` | Public subnet CIDR blocks |
| `private_subnets` | `list(string)` | Private subnet CIDR blocks |
| `map_public_ip_on_launch` | `bool` | Whether to map public IP on launch |
| `create_igw` | `bool` | Whether to create an internet gateway |
| `create_vpc` | `bool` | Whether to create the VPC |
| `create_egress_only_igw` | `bool` | Whether to create an egress-only IGW |
| `manage_default_security_group` | `bool` | Whether to manage the default security group |
| `manage_default_network_acl` | `bool` | Whether to manage the default network ACL |
| `manage_default_route_table` | `bool` | Whether to manage the default route table |
| `cdk_assets_bucket_name` | `string` | Name of the CDK assets S3 bucket |
| `instance_ami` | `string` | AMI ID for the EC2 instance |
| `instance_type` | `string` | EC2 instance type |
| `nacl_subnet_ids` | `list(string)` | Subnet IDs to associate with the network ACL |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `vpc_id` | The ID of the VPC |
| `public_subnets` | List of IDs of public subnets |
| `private_subnets` | List of IDs of private subnets |
| `igw_id` | The ID of the Internet Gateway |
| `instance_id` | The ID of the EC2 instance |
| `instance_private_ip` | The private IP of the EC2 instance |
| `network_interface_id` | The ID of the network interface |
| `sg_launch_wizard_id` | The ID of the launch-wizard security group |
| `sg_default_id` | The ID of the default security group |
| `sg_launch_wizard_1_id` | The ID of the launch-wizard-1 security group |
| `network_acl_id` | The ID of the network ACL |
| `cdk_assets_bucket_id` | The ID of the CDK assets S3 bucket |
| `private_runner_storage_bucket_id` | The ID of the private runner storage S3 bucket |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import existing resources

```sh
./imports.sh terraform
```

### 3. Plan

```sh
terraform plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```