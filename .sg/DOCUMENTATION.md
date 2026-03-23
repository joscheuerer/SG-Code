# VPC Networking Infrastructure

## Overview

This Terraform stack manages a complete VPC networking infrastructure in AWS, including:

- VPC with configurable CIDR block
- Public and private subnets across two availability zones (eu-central-1a and eu-central-1b)
- Internet gateway for public internet connectivity
- Route tables with custom routes and subnet associations
- Security groups with ingress and egress rules
- Network ACL with custom rules

## Architecture

The stack is organized into six modules:

1. **vpc**: Creates the VPC with specified CIDR block and instance tenancy
2. **subnet**: Manages multiple subnets with different configurations
3. **internet_gateway**: Provides internet connectivity for the VPC
4. **route_table**: Manages route tables, routes, and subnet associations
5. **security_group**: Manages security groups and their rules
6. **network_acl**: Manages network ACL and its rules

## Modules

### VPC Module (`modules/vpc`)

Creates a VPC with configurable CIDR block and instance tenancy.

**Resources:**
- `aws_vpc.this`

**Outputs:**
- `vpc_id`: VPC ID
- `owner_id`: VPC owner ID

### Subnet Module (`modules/subnet`)

Creates multiple subnets with different availability zones and public IP settings.

**Resources:**
- `aws_subnet.this` (for_each)

**Outputs:**
- `subnet_ids`: Map of subnet keys to subnet IDs

### Internet Gateway Module (`modules/internet_gateway`)

Creates an internet gateway attached to the VPC.

**Resources:**
- `aws_internet_gateway.this`

**Outputs:**
- `internet_gateway_id`: Internet gateway ID

### Route Table Module (`modules/route_table`)

Manages route tables, routes, and subnet associations.

**Resources:**
- `aws_route_table.this` (for_each)
- `aws_route.this` (for_each)
- `aws_route_table_association.this` (for_each)

**Outputs:**
- `route_table_ids`: Map of route table keys to route table IDs

### Security Group Module (`modules/security_group`)

Manages security groups and their ingress/egress rules.

**Resources:**
- `aws_security_group.this` (for_each)
- `aws_security_group_rule.this` (for_each)

**Outputs:**
- `security_group_ids`: Map of security group keys to security group IDs

### Network ACL Module (`modules/network_acl`)

Manages network ACL and its rules.

**Resources:**
- `aws_network_acl.this`
- `aws_network_acl_rule.this` (for_each)

**Outputs:**
- `network_acl_id`: Network ACL ID

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region | "eu-central-1" |

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

Before applying any changes, import the existing AWS resources:

```bash
chmod +x imports.sh
./imports.sh
```

### Plan Changes

Review the planned changes:

```bash
terraform plan -var-file=environments/terraform.tfvars
```

### Apply Configuration

Apply the Terraform configuration:

```bash
terraform apply -var-file=environments/terraform.tfvars
```

## Network Configuration

### Subnets

- **Public Subnets** (with auto-assign public IP):
  - `sg-vpc-xxklkl-public-eu-central-1a`: 10.0.1.0/24
  - `sg-vpc-xxklkl-public-eu-central-1b`: 10.0.2.0/24

- **Private Subnets**:
  - `sg-vpc-xxklkl-private-eu-central-1a`: 10.0.110.0/24
  - `sg-vpc-xxklkl-private-eu-central-1b`: 10.0.120.0/24

### Route Tables

- **Public Route Table**: Routes internet traffic (0.0.0.0/0) to the internet gateway
- **Private Route Tables**: Separate route tables for each private subnet
- **Default Route Table**: VPC default route table

### Security Groups

- **default**: Default VPC security group
- **vpc-092e2c24e01e5e088-20251126171749264400000001**: Custom security group with:
  - HTTP ingress (port 80) from anywhere
  - SSH ingress (port 22) from anywhere
  - All egress traffic allowed

### Network ACL

Default network ACL with:
- Allow all ingress traffic (rule 100)
- Allow all egress traffic (rule 100)
- Deny all ingress traffic (rule 32767, implicit)
- Deny all egress traffic (rule 32767, implicit)

## Notes

- This configuration imports existing AWS resources
- The VPC CIDR is 10.0.0.0/16
- All resources are tagged with appropriate names for identification
- Security group rules allow SSH and HTTP access from anywhere (0.0.0.0/0) - consider restricting in production