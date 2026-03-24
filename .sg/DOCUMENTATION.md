# sg-vpc-1109-network

VPC network infrastructure with public and private subnets across two availability zones

## Overview

This Terraform stack manages a complete VPC network infrastructure in AWS region `eu-central-1`. The stack includes:

- **VPC**: A Virtual Private Cloud with CIDR block 10.0.0.0/16
- **Subnets**: Four subnets across two availability zones (eu-central-1a and eu-central-1b)
  - Two public subnets with auto-assign public IP enabled
  - Two private subnets
- **Internet Gateway**: Provides internet connectivity for the VPC
- **Route Tables**: Four route tables managing traffic routing
  - One public route table with internet gateway route
  - Two private route tables (one per AZ)
  - One default route table
- **Security Groups**: Two security groups with ingress/egress rules
- **Network ACL**: Network access control list with subnet associations and rules

## Modules

### vpc
VPC with CIDR block and DHCP options

**Resources:**
- `aws_vpc.this`

**Outputs:**
- `vpc_id`: VPC ID
- `dhcp_options_id`: DHCP options ID

### subnet
VPC subnets across availability zones

**Resources:**
- `aws_subnet.this` (for_each)

**Outputs:**
- `subnet_ids`: Map of subnet keys to subnet IDs

### internet_gateway
Internet gateway for VPC internet connectivity

**Resources:**
- `aws_internet_gateway.this`

**Outputs:**
- `internet_gateway_id`: Internet gateway ID

### route_table
Route tables with subnet associations and routes

**Resources:**
- `aws_route_table.this` (for_each)
- `aws_route.this` (for_each)
- `aws_route_table_association.this` (for_each)

**Outputs:**
- `route_table_ids`: Map of route table keys to route table IDs

### security_group
Security groups with ingress and egress rules

**Resources:**
- `aws_security_group.this` (for_each)
- `aws_security_group_rule.this` (for_each)

**Outputs:**
- `security_group_ids`: Map of security group keys to security group IDs

### network_acl
Network ACL with subnet associations and rules

**Resources:**
- `aws_network_acl.this`
- `aws_network_acl_rule.this` (for_each)

**Outputs:**
- `network_acl_id`: Network ACL ID

## Variables

| Name | Type | Description |
|------|------|-------------|
| region | string | AWS region |
| subnets | map(object) | Subnet configurations |
| route_tables | map(object) | Route table configurations |
| routes | map(object) | Routes to create in route tables |
| route_table_associations | map(object) | Route table to subnet associations |
| security_groups | map(object) | Security group configurations |
| security_group_rules | map(object) | Security group rules to create |
| acl_rules | map(object) | Network ACL rules to create |

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

This stack is designed to import existing AWS resources. Run the import script:

```bash
chmod +x imports.sh
./imports.sh
```

### Plan Changes

```bash
terraform plan -var-file=environments/terraform.tfvars
```

After import, this should show zero changes (zero drift).

### Apply Configuration

```bash
terraform apply -var-file=environments/terraform.tfvars
```

## Notes

- The stack imports existing resources and should show zero drift after import
- All resource IDs are hardcoded in the import script
- The VPC uses CIDR block 10.0.0.0/16 with default instance tenancy
- Public subnets have auto-assign public IP enabled
- The public route table includes a default route (0.0.0.0/0) to the internet gateway
- Security group rules include SSH (port 22) and HTTP (port 80) ingress, plus all egress traffic
- Network ACL rules allow all traffic by default with explicit deny rules at priority 32767