# basic-eks-vpc-infrastructure

## Description

VPC infrastructure for basic-eks including subnets, route tables, internet gateway, security groups, and network ACL in eu-central-1.

## Architecture Overview

This stack provisions the complete networking layer for a basic EKS cluster in `eu-central-1`. It includes:

- A single VPC (`10.0.0.0/16`)
- 6 subnets across 3 AZs (3 public, 3 private)
- An internet gateway
- 3 route tables (public, private, default)
- 4 security groups (cluster, node, outpost, default)
- A network ACL applied to all subnets

## Module Overview

| Module | Description |
|--------|-------------|
| `vpc` | Manages the basic-eks VPC |
| `subnet` | Manages subnets within the VPC (for_each) |
| `internet_gateway` | Manages the internet gateway attached to the VPC |
| `route_table` | Manages route tables within the VPC (for_each) |
| `security_group` | Manages security groups within the VPC (for_each) |
| `network_acl` | Manages the network ACL for the VPC subnets |

## Variables Reference

| Variable | Type | Description |
|----------|------|-------------|
| `region` | `string` | AWS region |
| `vpc_cidr_block` | `string` | The IPv4 CIDR block for the VPC |
| `vpc_instance_tenancy` | `string` | Tenancy option for instances launched into the VPC |
| `vpc_tags` | `map(string)` | Tags to assign to the VPC |
| `subnets` | `map(object)` | Map of subnet configurations |
| `internet_gateway_tags` | `map(string)` | Tags to assign to the internet gateway |
| `route_tables` | `map(object)` | Map of route table configurations |
| `security_groups` | `map(object)` | Map of security group configurations |
| `network_acl_egress` | `list(object)` | Egress rules for the network ACL |
| `network_acl_ingress` | `list(object)` | Ingress rules for the network ACL |
| `network_acl_tags` | `map(string)` | Tags to assign to the network ACL |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `vpc_id` | The ID of the VPC |
| `subnet_basic_eks_public_eu_central_1b_id` | The ID of the basic-eks-public-eu-central-1b subnet |
| `subnet_basic_eks_private_eu_central_1b_id` | The ID of the basic-eks-private-eu-central-1b subnet |
| `subnet_basic_eks_public_eu_central_1a_id` | The ID of the basic-eks-public-eu-central-1a subnet |
| `subnet_basic_eks_private_eu_central_1c_id` | The ID of the basic-eks-private-eu-central-1c subnet |
| `subnet_basic_eks_public_eu_central_1c_id` | The ID of the basic-eks-public-eu-central-1c subnet |
| `subnet_basic_eks_private_eu_central_1a_id` | The ID of the basic-eks-private-eu-central-1a subnet |
| `internet_gateway_id` | The ID of the internet gateway |
| `route_table_basic_eks_private_id` | The ID of the basic-eks-private route table |
| `route_table_basic_eks_public_id` | The ID of the basic-eks-public route table |
| `route_table_basic_eks_default_id` | The ID of the basic-eks-default route table |
| `security_group_basic_eks_cluster_id` | The ID of the basic-eks-cluster security group |
| `security_group_outpost_id` | The ID of the outpost security group |
| `security_group_basic_eks_node_id` | The ID of the basic-eks-node security group |
| `security_group_default_id` | The ID of the default security group |
| `network_acl_id` | The ID of the network ACL |

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