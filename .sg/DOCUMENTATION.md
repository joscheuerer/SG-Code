# sage-agent-ecr

## Description

ECR repository for the sage-agent container image with lifecycle policy and Lambda access repository policy.

## Stack Overview

| Component | Details |
|-----------|---------|
| Stack Name | sage-agent-ecr |
| Region | eu-central-1 |
| Provider | AWS (hashicorp/aws) |

## Modules

### `ecr_repository` (`./modules/ecr_repository`)

Manages the sage-agent ECR repository including image scanning, encryption, and tag mutability settings.

**Resources:**
| Resource Type | Logical Name | Description |
|---------------|--------------|-------------|
| `aws_ecr_repository` | `this` | The ECR repository for the sage-agent container image |

## Variables Reference

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `region` | `string` | AWS region where resources will be managed | `"eu-central-1"` |
| `name` | `string` | Name of the ECR repository | `"sage-agent"` |
| `image_tag_mutability` | `string` | The tag mutability setting for the repository | `"MUTABLE"` |
| `encryption_type` | `string` | The encryption type to use for the repository | `"AES256"` |
| `scan_on_push` | `bool` | Indicates whether images are scanned after being pushed | `true` |
| `tags` | `map(string)` | A map of tags to assign to the repository | See tfvars |

## Outputs Reference

| Name | Description |
|------|-------------|
| `repository_url` | The URL of the ECR repository |
| `registry_id` | The registry ID where the repository was created |
| `arn` | Full ARN of the ECR repository |
| `name` | Name of the ECR repository |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import Existing Resources

```sh
chmod +x imports.sh
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