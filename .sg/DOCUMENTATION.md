# S3 Private Runner Storage

## Overview

This Terraform stack manages S3 buckets for private runner storage backend in the eu-central-1 region. The stack creates two S3 buckets with comprehensive security configurations including public access blocking, ownership controls, and server-side encryption.

## Stack Description

S3 buckets for private runner storage backend

## Module Overview

### s3_bucket

S3 bucket with security and encryption configuration

**Resources:**
- `aws_s3_bucket` - Main S3 bucket
- `aws_s3_bucket_public_access_block` - Public access blocking configuration
- `aws_s3_bucket_ownership_controls` - Object ownership controls
- `aws_s3_bucket_server_side_encryption_configuration` - Server-side encryption settings

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region for resources | - |

## Outputs

| Name | Description |
|------|-------------|
| bucket_2dlru2rs_id | The ID of the 2dlru2rs bucket |
| bucket_2dlru2rs_arn | The ARN of the 2dlru2rs bucket |
| bucket_37lxrdhe_id | The ID of the 37lxrdhe bucket |
| bucket_37lxrdhe_arn | The ARN of the 37lxrdhe bucket |

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

## Security Features

- **Public Access Blocking**: All buckets block public ACLs and policies
- **Object Ownership**: Enforced bucket owner ownership
- **Encryption**: AES256 server-side encryption enabled
- **Access Control**: Comprehensive public access restrictions

## Bucket Configuration

Both buckets are configured with:
- Public access completely blocked
- BucketOwnerEnforced object ownership
- AES256 server-side encryption
- S3 Bucket Key disabled