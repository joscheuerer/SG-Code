# eks-vpc-internet-gateway

## Description

Internet Gateway for EKS VPC (vpc-eks) attached to vpc-0b77450939be7f679 in eu-west-2.

This stack manages an AWS Internet Gateway using the external `terraform-aws-vpc` module. The VPC itself is not managed here (`create_vpc = false`); only the Internet Gateway resource is imported and managed.

## Module Overview

| Module | Source | Description |
|--------|--------|-------------|
| `vpc_eks` | `git::https://github.com/StackGuardian/terraform-aws-vpc.git?ref=master` | AWS VPC module used to manage the Internet Gateway for the EKS VPC |

## Variables Reference

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `region` | `string` | AWS region | `"eu-west-2"` |
| `name` | `string` | Name identifier for resources | `"vpc-eks"` |
| `create_vpc` | `bool` | Controls if VPC should be created | `false` |
| `create_igw` | `bool` | Controls if an Internet Gateway is created | `true` |
| `create_egress_only_igw` | `bool` | Controls if an Egress Only Internet Gateway is created | `false` |
| `enable_nat_gateway` | `bool` | Controls if NAT Gateways are provisioned | `false` |
| `create_flow_log_cloudwatch_iam_role` | `bool` | Whether to create IAM role for VPC Flow Logs | `false` |
| `create_flow_log_cloudwatch_log_group` | `bool` | Whether to create CloudWatch log group for VPC Flow Logs | `false` |
| `igw_tags` | `map(string)` | Additional tags for the Internet Gateway | see tfvars |
| `tags` | `map(string)` | A map of tags to add to all resources | see tfvars |

## Outputs Reference

| Name | Description |
|------|-------------|
| `igw_id` | The ID of the Internet Gateway |
| `igw_arn` | The ARN of the Internet Gateway |

## Usage Instructions

### 1. Initialize

```sh
terraform init
# or
tofu init
```

### 2. Import existing resources

```sh
./imports.sh terraform
# or
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

## Notes

- `create_vpc = false` ensures the VPC itself is not created or managed by this stack.
- The Internet Gateway (`igw-00feab76abd7ba8e7`) is imported into state via `imports.sh`.
- The VPC (`vpc-0b77450939be7f679`) is an external dependency and must exist prior to applying this stack.