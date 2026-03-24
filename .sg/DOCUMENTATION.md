# VPC Networking Stack

## Overview

This Terraform stack manages a VPC with private subnet, route table, and network ACL configuration in AWS. The stack imports existing cloud resources to enable infrastructure-as-code management without recreating resources.

## Stack Description

VPC with private subnet, route table, and network ACL configuration

**Region:** eu-central-1

## Architecture

The stack consists of four modules:

1. **vpc** - Manages VPC with CIDR block configuration
2. **subnet** - Manages VPC subnet with availability zone placement
3. **route_table** - Manages route table with subnet associations
4. **network_acl** - Manages default network ACL with ingress and egress rules

## Modules

### vpc

Manages VPC with CIDR block configuration.

**Resources:**
- `aws_vpc.this` - VPC resource with DNS and tenancy configuration

**Inputs:**

| Name | Type | Description | Required |
|------|------|-------------|----------|
| cidr_block | string | The IPv4 CIDR block for the VPC | Yes |
| instance_tenancy | string | Tenancy option for instances launched into the VPC | Yes |
| enable_dns_hostnames | bool | Enable DNS hostnames in the VPC | Yes |
| enable_dns_support | bool | Enable DNS support in the VPC | Yes |
| tags | map(string) | Tags to apply to the VPC | Yes |

**Outputs:**

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| cidr_block | The CIDR block of the VPC |

### subnet

Manages VPC subnet with availability zone placement.

**Resources:**
- `aws_subnet.this` - Subnet resource in specified availability zone

**Inputs:**

| Name | Type | Description | Required |
|------|------|-------------|----------|
| vpc_id | string | The VPC ID where the subnet will be created | Yes |
| cidr_block | string | The IPv4 CIDR block for the subnet | Yes |
| availability_zone | string | The availability zone for the subnet | Yes |
| map_public_ip_on_launch | bool | Whether instances launched in this subnet receive a public IP | Yes |
| tags | map(string) | Tags to apply to the subnet | Yes |

**Outputs:**

| Name | Description |
|------|-------------|
| subnet_id | The ID of the subnet |
| availability_zone | The availability zone of the subnet |

### route_table

Manages route table with subnet associations.

**Resources:**
- `aws_route_table.this` - Route table resource
- `aws_route_table_association.this` - Route table associations (for_each)

**Inputs:**

| Name | Type | Description | Required |
|------|------|-------------|----------|
| vpc_id | string | The VPC ID where the route table will be created | Yes |
| tags | map(string) | Tags to apply to the route table | Yes |
| subnet_associations | map(object) | Map of subnet associations for the route table | No (default: {}) |

**Outputs:**

| Name | Description |
|------|-------------|
| route_table_id | The ID of the route table |

### network_acl

Manages default network ACL with ingress and egress rules.

**Resources:**
- `aws_default_network_acl.this` - Default network ACL with custom rules

**Inputs:**

| Name | Type | Description | Required |
|------|------|-------------|----------|
| default_network_acl_id | string | The ID of the default network ACL | Yes |
| ingress_rules | list(object) | Ingress rules for the network ACL | Yes |
| egress_rules | list(object) | Egress rules for the network ACL | Yes |

**Outputs:**

| Name | Description |
|------|-------------|
| network_acl_id | The ID of the network ACL |

## Root Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region for the resources | eu-central-1 |
| default_network_acl_id | string | The ID of the default network ACL | acl-0f144cadadcd92531 |

## Root Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| subnet_id | The ID of the private subnet |
| route_table_id | The ID of the route table |
| network_acl_id | The ID of the network ACL |

## Usage

### Prerequisites

- Terraform >= 1.0
- AWS Provider ~> 5.0
- AWS credentials configured
- Existing AWS resources with IDs matching the import configuration

### Deployment Steps

1. **Initialize Terraform:**

```bash
terraform init
```

2. **Import Existing Resources:**

```bash
chmod +x imports.sh
./imports.sh
```

This will import:
- VPC (vpc-0e383da95ac6085aa)
- Subnet (subnet-0320b43671a4327ed)
- Route table (rtb-09cc05b9fccf565c9)
- Route table association
- Default network ACL (acl-0f144cadadcd92531)

3. **Review the Plan:**

```bash
terraform plan -var-file=environments/terraform.tfvars
```

After import, this should show no changes (zero drift).

4. **Apply Configuration:**

```bash
terraform apply -var-file=environments/terraform.tfvars
```

### Customization

To customize for different environments:

1. Copy `environments/terraform.tfvars` to a new file (e.g., `environments/production.tfvars`)
2. Update the variable values as needed
3. Use `-var-file=environments/production.tfvars` in terraform commands

### Network ACL Rules

The default network ACL is configured with:

**Ingress:**
- Rule 100: Allow all traffic from 0.0.0.0/0
- Rule 32767: Deny all traffic (default deny)

**Egress:**
- Rule 100: Allow all traffic to 0.0.0.0/0
- Rule 32767: Deny all traffic (default deny)

## Notes

- This stack imports existing resources - ensure IDs in imports.sh match your AWS resources
- The subnet is configured as private (map_public_ip_on_launch = false)
- DNS hostnames and DNS support are enabled on the VPC
- The route table is associated with the private subnet in eu-central-1b
- All resources are tagged for identification and management