# sg-vpc-092-network

VPC network infrastructure with public and private subnets across two availability zones

## Overview

This Terraform stack manages a complete VPC network infrastructure in AWS, including:

- VPC with DNS support and hostnames enabled
- 4 subnets across 2 availability zones (2 public, 2 private)
- Internet gateway for public internet access
- Route tables with associations for public and private subnets
- Security groups with ingress/egress rules
- Network ACL with rules for traffic control

## Modules

### vpc
VPC with CIDR block and DHCP options

### subnet
Subnets in multiple availability zones

### internet_gateway
Internet gateway for VPC

### route_table
Route tables with associations and routes

### security_group
Security groups with ingress and egress rules

### network_acl
Network ACL with rules and subnet associations

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region | eu-central-1 |
| enable_dns_hostnames | bool | Enable DNS hostnames in the VPC | true |
| enable_dns_support | bool | Enable DNS support in the VPC | true |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| subnet_ids | Map of subnet keys to subnet IDs |
| internet_gateway_id | Internet gateway ID |
| route_table_ids | Map of route table keys to route table IDs |
| security_group_ids | Map of security group keys to security group IDs |
| network_acl_id | Network ACL ID |

## Usage

### Initialize Terraform

```bash
terraform init
```

### Import Existing Resources

```bash
chmod +x imports.sh
./imports.sh
```

### Plan Changes

```bash
terraform plan -var-file=environments/terraform.tfvars
```

### Apply Configuration

```bash
terraform apply -var-file=environments/terraform.tfvars
```

## Network Architecture

- **VPC CIDR**: 10.0.0.0/16
- **Public Subnets**: 
  - eu-central-1a: 10.0.1.0/24
  - eu-central-1b: 10.0.2.0/24
- **Private Subnets**:
  - eu-central-1a: 10.0.110.0/24
  - eu-central-1b: 10.0.120.0/24

Public subnets have internet access via the internet gateway and public route table. Private subnets use separate route tables without internet gateway routes.