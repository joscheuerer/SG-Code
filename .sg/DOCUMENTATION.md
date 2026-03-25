# Multi-Resource Infrastructure Stack

## Overview

This Terraform stack manages S3 bucket, EBS volume, and network interface resources in AWS. The infrastructure is organized into three reusable modules that handle storage, block storage, and networking components.

## Stack Description

S3 bucket, EBS volume, and network interface resources deployed in the eu-central-1 region.

## Modules

### s3_bucket

S3 bucket with encryption and public access blocking.

**Resources:**
- `aws_s3_bucket` - S3 bucket
- `aws_s3_bucket_server_side_encryption_configuration` - Server-side encryption with AES256
- `aws_s3_bucket_public_access_block` - Public access blocking configuration
- `aws_s3_bucket_ownership_controls` - Bucket ownership controls

### ebs_volume

EBS volume with gp3 type.

**Resources:**
- `aws_ebs_volume` - EBS volume with configurable size, IOPS, and throughput

### network_interface

Network interface for load balancer.

**Resources:**
- `aws_network_interface` - Network interface with private IP configuration

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region | - |
| subnet_id | string | Subnet ID for network interface | - |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | ID of the S3 bucket |
| volume_id | ID of the EBS volume |
| network_interface_id | ID of the network interface |

## Usage

### Initialize Terraform

```bash
terraform init
```

### Import Existing Resources

Before applying any changes, import the existing resources:

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

## Module Instances

### storage_backend

S3 bucket for private runner storage backend.

- **Bucket Name:** 41n9oxq3-private-runner-storage-backend
- **Encryption:** AES256
- **Public Access:** Blocked

### ebs_volume

GP3 EBS volume in eu-central-1a.

- **Size:** 100 GB
- **IOPS:** 3000
- **Throughput:** 125 MB/s
- **Availability Zone:** eu-central-1a

### platform_api_eni

Network interface for platform API load balancer.

- **Subnet:** subnet-072669658da496c4a
- **Private IP:** 10.0.0.48
- **Description:** ELB net/platform-api-qa/db2a5cb2e2c0ca9a

## Notes

- All resources are imported from existing infrastructure
- Run `terraform plan` after import to verify zero drift
- The S3 bucket uses BucketOwnerEnforced ownership controls
- The network interface has source/destination checking disabled