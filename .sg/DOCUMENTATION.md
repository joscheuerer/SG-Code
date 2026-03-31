# Private Runner Storage

S3 buckets for private runner storage backends

## Overview

This Terraform stack manages two S3 buckets configured as storage backends for private runners. Each bucket is configured with:

- Bucket ownership controls (BucketOwnerEnforced)
- Public access blocking (all options enabled)
- Server-side encryption (AES256)

## Architecture

The stack uses a reusable `s3_bucket` module that creates:

- S3 bucket
- Ownership controls
- Public access block settings
- Server-side encryption configuration

Two instances of this module are deployed:
- `bucket_7beoi78w`: 7beoi78w-private-runner-storage-backend
- `bucket_7ungwu6v`: 7ungwu6v-private-runner-storage-backend

## Modules

### s3_bucket

Manages S3 bucket with security and encryption settings

**Location:** `modules/s3_bucket/`

**Resources:**
- `aws_s3_bucket.this` - S3 bucket
- `aws_s3_bucket_ownership_controls.this` - Ownership controls
- `aws_s3_bucket_public_access_block.this` - Public access block
- `aws_s3_bucket_server_side_encryption_configuration.this` - Encryption configuration

## Variables

### Root Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region for the resources | "eu-central-1" |

### Module Variables (s3_bucket)

| Name | Type | Description | Required |
|------|------|-------------|----------|
| bucket_name | string | Name of the S3 bucket | Yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket_7beoi78w_id | The ID of the 7beoi78w S3 bucket |
| bucket_7beoi78w_arn | The ARN of the 7beoi78w S3 bucket |
| bucket_7ungwu6v_id | The ID of the 7ungwu6v S3 bucket |
| bucket_7ungwu6v_arn | The ARN of the 7ungwu6v S3 bucket |

## Usage

### Initial Setup

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Import Existing Resources:**
   ```bash
   chmod +x imports.sh
   ./imports.sh
   ```

3. **Verify Configuration:**
   ```bash
   terraform plan -var-file=environments/terraform.tfvars
   ```

   This should show no changes if the import was successful.

4. **Apply Configuration (if needed):**
   ```bash
   terraform apply -var-file=environments/terraform.tfvars
   ```

### Making Changes

After the initial import, you can modify the configuration and apply changes:

```bash
terraform plan -var-file=environments/terraform.tfvars
terraform apply -var-file=environments/terraform.tfvars
```

### Viewing Outputs

```bash
terraform output
```

## Security Features

- **Public Access Blocked:** All public access is blocked at the bucket level
- **Encryption:** AES256 server-side encryption enabled by default
- **Ownership Controls:** BucketOwnerEnforced ensures consistent ownership
- **No Hardcoded Credentials:** All authentication uses AWS provider configuration

## Region

All resources are deployed in: **eu-central-1**