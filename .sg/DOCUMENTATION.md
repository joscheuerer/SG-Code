# cloudformation-stacks

## Description

AWS CloudFormation stacks managing VPC infrastructure and IAM connector role in eu-central-1.

## Module Overview

| Module | Description |
|--------|-------------|
| `cloudformation_stack` | Manages an AWS CloudFormation stack |

## Resources

| Resource Type | Logical Name | Description |
|---------------|--------------|-------------|
| `aws_cloudformation_stack` | `this` | CloudFormation stack resource |

## Stack Instances

| Key | Stack Name | Purpose |
|-----|------------|---------|
| `stackguardian_connector_role` | StackGuardianConnectorRole | IAM connector role for StackGuardian |
| `vpc_1` | vpc-1 | VPC infrastructure stack (stackguardian/dev) |
| `vpc_2` | vpc-2 | VPC infrastructure stack (approvalv2/dev2) |

## Variables Reference

| Variable | Type | Description |
|----------|------|-------------|
| `region` | `string` | AWS region |
| `cloudformation_stacks` | `map(object({...}))` | Map of CloudFormation stacks to manage |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `stackguardian_connector_role_outputs` | Outputs from the StackGuardian connector role stack |
| `vpc_1_outputs` | Outputs from the vpc-1 stack |
| `vpc_2_outputs` | Outputs from the vpc-2 stack |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import existing resources

```sh
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