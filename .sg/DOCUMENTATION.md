# private-runner-storage

S3 bucket for private runner storage backend with encryption and public access blocking

## Overview

This Terraform stack manages an S3 bucket configured for private runner storage with comprehensive security settings including server-side encryption, public access blocking, ownership controls, and versioning configuration.

## Modules

### s3_bucket

Manages S3 bucket with server-side encryption and public access block configuration

**Resources:**
- `aws_s3_bucket` - Main S3 bucket
- `aws_s3_bucket_ownership_controls` - Object ownership controls
- `aws_s3_bucket_server_side_encryption_configuration` - Server-side encryption settings
- `aws_s3_bucket_public_access_block` - Public access block configuration
- `aws_s3_bucket_versioning` - Versioning configuration

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region for the resources | - |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The ID of the S3 bucket |
| bucket_arn | The ARN of the S3 bucket |

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

The stack creates a single S3 bucket (`41n9oxq3-private-runner-storage-backend`) with the following security configurations:

- **Encryption**: AES256 server-side encryption
- **Public Access**: All public access blocked
- **Ownership**: BucketOwnerEnforced
- **Versioning**: Disabled
- **Bucket Key**: Disabled

## Region

All resources are deployed in the `eu-central-1` region.