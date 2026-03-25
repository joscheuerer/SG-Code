# IAM Lambda@Edge Roles Stack

## Overview

This stack manages IAM roles for Lambda@Edge functions with CloudWatch Logs and S3 permissions. The infrastructure imports existing IAM roles and their inline policies into Terraform management.

## Stack Description

IAM roles for Lambda@Edge functions with CloudWatch Logs and S3 permissions

**Region:** global

## Modules

### iam_role

Manages IAM role with inline policies for Lambda@Edge execution

**Resources:**
- `aws_iam_role.this` - IAM role with trust policy
- `aws_iam_role_policy.this` - Inline policies attached to the role

## Variables

| Name | Type | Description | Required |
|------|------|-------------|----------|
| region | string | AWS region | Yes |
| roles | map(string) | Map of role keys to role names | Yes |
| assume_role_policy_document | object | Trust policy document for role assumption | Yes |
| inline_policies | map(map(object)) | Inline policies to attach to roles | Yes |

## Outputs

| Name | Description |
|------|-------------|
| role_ids | List of IAM role unique IDs |
| role_arns | List of IAM role ARNs |

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

## Notes

- This stack imports existing IAM resources
- The roles are configured for Lambda@Edge execution with trust policies for both lambda.amazonaws.com and edgelambda.amazonaws.com
- Each role has inline policies granting CloudWatch Logs permissions and S3 access to the xstack-landing-nonprod bucket
- Maximum session duration is set to 3600 seconds (1 hour)