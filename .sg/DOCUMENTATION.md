# IAM Role for Lambda@Edge

## Overview

This Terraform stack manages an IAM role configured for Lambda@Edge functions with permissions for S3 and CloudWatch Logs.

## Stack Description

- **Name**: iam-role-lambda-edge
- **Region**: global
- **Description**: IAM role for Lambda@Edge with S3 and CloudWatch Logs permissions

## Module Overview

### iam_role

Manages an IAM role with assume role policy and inline policies.

**Resources:**
- `aws_iam_role.this` - IAM role with trust policy
- `aws_iam_role_policy.this` - Inline policies attached to the role

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region | - |
| inline_policies | map(object) | Inline policies to attach to the role | - |

### inline_policies Object Structure

```hcl
{
  policy_name     = string
  policy_document = object
}
```

## Outputs

| Name | Description |
|------|-------------|
| role_id | ID of the Lambda@Edge IAM role |
| role_arn | ARN of the Lambda@Edge IAM role |

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

## Configuration Details

The IAM role is configured with:

- **Trust Policy**: Allows assumption by `lambda.amazonaws.com` and `edgelambda.amazonaws.com`
- **Session Duration**: 3600 seconds (1 hour)
- **Inline Policy**: Grants permissions for CloudWatch Logs and S3 operations

### Permissions Granted

**CloudWatch Logs:**
- CreateLogGroup
- CreateLogStream
- PutLogEvents

**S3:**
- GetObject
- PutObject (scoped to `xstack-landing-nonprod` bucket)

## Notes

- This stack imports existing IAM resources
- The role name `0eu096k-9ci2y0p` is fixed and should not be changed
- After import, `terraform plan` should show zero changes