# VPC Networking Stack

## Overview

This stack provisions a complete VPC networking infrastructure with public and private subnets across two availability zones in the eu-central-1 region. The infrastructure includes:

- VPC with CIDR block 10.0.0.0/16
- Four subnets (two public, two private) across eu-central-1a and eu-central-1b
- Internet gateway for public internet connectivity
- Route tables with appropriate routing configurations
- Default security group
- Network ACL with ingress and egress rules

## Architecture

The stack is organized into six modules:

1. **vpc**: Creates the VPC with configurable CIDR block and instance tenancy
2. **subnet**: Manages multiple subnets within the VPC
3. **internet_gateway**: Provides internet connectivity for the VPC
4. **route_table**: Manages route tables, routes, and subnet associations
5. **security_group**: Creates the default VPC security group
6. **network_acl**: Manages network ACL and associated rules

## Modules

### VPC Module (`modules/vpc`)

Creates the VPC with specified CIDR block and instance tenancy.

**Resources:**
- `aws_vpc.this`

**Outputs:**
- `vpc_id`: ID of the VPC
- `owner_id`: Owner ID of the VPC

### Subnet Module (`modules/subnet`)

Creates multiple subnets within the VPC with configurable CIDR blocks and availability zones.

**Resources:**
- `aws_subnet.this` (for_each)

**Outputs:**
- `subnet_ids`: Map of subnet keys to subnet IDs

### Internet Gateway Module (`modules/internet_gateway`)

Attaches an internet gateway to the VPC for public internet connectivity.

**Resources:**
- `aws_internet_gateway.this`

**Outputs:**
- `internet_gateway_id`: ID of the internet gateway

### Route Table Module (`modules/route_table`)

Manages route tables, routes, and subnet associations.

**Resources:**
- `aws_route_table.this` (for_each)
- `aws_route.this` (for_each)
- `aws_route_table_association.this` (for_each)

**Outputs:**
- `route_table_ids`: Map of route table keys to route table IDs

### Security Group Module (`modules/security_group`)

Creates the default VPC security group.

**Resources:**
- `aws_security_group.this`

**Outputs:**
- `security_group_id`: ID of the security group

### Network ACL Module (`modules/network_acl`)

Manages network ACL and associated rules for subnet-level traffic control.

**Resources:**
- `aws_network_acl.this`
- `aws_network_acl_rule.this` (for_each)

**Outputs:**
- `network_acl_id`: ID of the network ACL

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region for the stack | - |
| subnets | map(object) | Map of subnets to create | - |
| route_tables | map(object) | Map of route tables to create | - |
| routes | map(object) | Map of routes to create | - |
| route_table_associations | map(object) | Map of route table to subnet associations | - |
| network_acl_subnet_ids | list(string) | List of subnet IDs for network ACL | - |
| network_acl_rules | map(object) | Map of network ACL rules to create | - |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| subnet_ids | Map of subnet keys to subnet IDs |
| internet_gateway_id | ID of the internet gateway |
| route_table_ids | Map of route table keys to route table IDs |
| security_group_id | ID of the security group |
| network_acl_id | ID of the network ACL |

## Usage

### Initialize Terraform

```bash
terraform init
```

### Import Existing Resources

Before applying changes, import the existing infrastructure:

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

Apply the configuration to achieve zero drift:

```bash
terraform apply -var-file=environments/terraform.tfvars
```

## Network Configuration

### Subnets

- **subnetname1**: 10.0.10.0/24 (eu-central-1a, public)
- **subnetname2**: 10.0.20.0/24 (eu-central-1b, public)
- **privatesubnetname1**: 10.0.110.0/24 (eu-central-1a, private)
- **privatesubnetname2**: 10.0.120.0/24 (eu-central-1b, private)

### Route Tables

- **do_not_delete-public**: Routes traffic to internet gateway (0.0.0.0/0)
- **do_not_delete-default**: Default route table
- **do_not_delete-private-eu-central-1a**: Private route table for AZ 1a
- **do_not_delete-private-eu-central-1b**: Private route table for AZ 1b

### Network ACL Rules

The network ACL allows all inbound and outbound traffic for both IPv4 and IPv6:

- Egress rule 100: Allow all IPv4 traffic
- Egress rule 101: Allow all IPv6 traffic
- Ingress rule 100: Allow all IPv4 traffic
- Ingress rule 101: Allow all IPv6 traffic

## Notes

- This configuration imports existing AWS resources to achieve zero drift
- All resources are tagged with "do_not_delete" to prevent accidental deletion
- The stack uses Terraform >= 1.0 and AWS provider ~> 5.0