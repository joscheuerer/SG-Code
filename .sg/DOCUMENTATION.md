# IAM Role for Lambda@Edge

## Overview

This Terraform stack manages an IAM role configured for Lambda@Edge functions with permissions for CloudWatch Logs and S3 access.

## Stack Description

The stack creates an IAM role that can be assumed by both Lambda and Lambda@Edge services. The role includes inline policies granting permissions to:
- Create and write to CloudWatch Logs
- Read and write objects in the `xstack-landing-nonprod` S3 bucket

## Module Overview

### iam_role

Manages an IAM role with customizable assume role policy and inline policies.

**Resources:**
- `aws_iam_role.this` - The IAM role
- `aws_iam_role_policy.this` - Inline policies attached to the role (for_each)

## Variables

### Root Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region | us-east-1 |

### Module Variables (iam_role)

| Name | Type | Description | Default |
|------|------|-------------|---------|
| name | string | Name of the IAM role | - |
| path | string | Path for the IAM role | - |
| assume_role_policy_document | object | Assume role policy document structure | - |
| max_session_duration | number | Maximum session duration in seconds | - |
| inline_policies | map(object) | Map of inline policies to attach to the role | {} |

## Outputs

| Name | Description |
|------|-------------|
| role_arn | ARN of the Lambda@Edge IAM role |
| role_name | Name of the Lambda@Edge IAM role |

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
- The role is configured for Lambda@Edge, which requires deployment in us-east-1
- After import, `terraform plan` should show no changes (zero drift)