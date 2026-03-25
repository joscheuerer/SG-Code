# S3 Private Runner Storage

## Overview

This Terraform stack manages S3 buckets for private runner storage backends with encryption and public access blocking. The stack creates two S3 buckets with consistent security configurations including server-side encryption, public access blocking, object ownership controls, and versioning.

## Stack Description

S3 buckets for private runner storage backends with encryption and public access blocking

**Region:** eu-central-1

## Modules

### s3_bucket

S3 bucket with server-side encryption, public access block, and object ownership controls

**Resources:**
- `aws_s3_bucket` - Main S3 bucket
- `aws_s3_bucket_server_side_encryption_configuration` - Server-side encryption configuration
- `aws_s3_bucket_public_access_block` - Public access blocking configuration
- `aws_s3_bucket_ownership_controls` - Object ownership controls
- `aws_s3_bucket_versioning` - Versioning configuration

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region for the resources | - |

## Outputs

| Name | Description |
|------|-------------|
| bucket_2dlru2rs_id | The ID of the 2dlru2rs bucket |
| bucket_2dlru2rs_arn | The ARN of the 2dlru2rs bucket |
| bucket_37lxrdhe_id | The ID of the 37lxrdhe bucket |
| bucket_37lxrdhe_arn | The ARN of the 37lxrdhe bucket |

## Module Instances

### bucket_2dlru2rs

S3 bucket: `2dlru2rs-private-runner-storage-backend`

**Configuration:**
- Encryption: AES256
- Public access: Blocked
- Object ownership: BucketOwnerEnforced
- Versioning: Suspended

### bucket_37lxrdhe

S3 bucket: `37lxrdhe-private-runner-storage-backend`

**Configuration:**
- Encryption: AES256
- Public access: Blocked
- Object ownership: BucketOwnerEnforced
- Versioning: Suspended

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

- **Server-Side Encryption:** All buckets use AES256 encryption
- **Public Access Blocking:** All public access is blocked at the bucket level
- **Object Ownership:** BucketOwnerEnforced ensures consistent ownership
- **Versioning:** Configured but currently suspended for both buckets