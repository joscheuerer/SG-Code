# non-prod-data-lake-infrastructure

## Description

Non-production data lake infrastructure including a Lambda execution IAM role and five S3 buckets forming a medallion architecture (landing, bronze, silver, gold, athena-results).

## Architecture Overview

This stack provisions:
- **IAM Role**: A Lambda execution role (`non-prod-file-processor-lambda-role`) with inline policies granting access to S3, SQS, CloudWatch Logs, Athena, and Glue, plus the `AWSLambdaBasicExecutionRole` managed policy.
- **S3 Buckets (Medallion Architecture)**:
  - `non-prod-infra-landing-raw` — Landing zone for raw unvalidated ingestion
  - `non-prod-infra-lake-bronze` — Bronze layer for raw validated permanent storage
  - `non-prod-infra-lake-silver` — Silver layer for normalized Iceberg tables
  - `non-prod-infra-lake-gold` — Gold layer for aggregated analytics
  - `non-prod-infra-athena-results` — Athena query output storage

## Module Overview

| Module | Source | Description |
|--------|--------|-------------|
| `iam_role` | `./modules/iam_role` | Lambda execution IAM role with inline policies and managed policy attachments |
| `s3_bucket` | `./modules/s3_bucket` | S3 bucket (instantiated once per entry in `s3_buckets` map) |

## Variables Reference

| Variable | Type | Description |
|----------|------|-------------|
| `region` | `string` | AWS region where resources will be managed |
| `iam_role_name` | `string` | Friendly name of the IAM role |
| `iam_role_path` | `string` | Path to the IAM role |
| `iam_role_max_session_duration` | `number` | Maximum session duration in seconds |
| `iam_role_assume_role_policy` | `string` | JSON policy document granting permission to assume the role |
| `iam_role_managed_policy_arns` | `set(string)` | Set of managed policy ARNs to attach to the role |
| `iam_role_inline_policies` | `map(object({...}))` | Map of inline policies to attach to the role |
| `iam_role_tags` | `map(string)` | Tags to assign to the IAM role |
| `s3_buckets` | `map(object({...}))` | Map of S3 bucket configurations (bucket name + tags) |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `iam_role_arn` | ARN of the Lambda execution IAM role |
| `iam_role_name` | Name of the Lambda execution IAM role |
| `s3_bucket_athena_results_id` | ID of the Athena results S3 bucket |
| `s3_bucket_lake_bronze_id` | ID of the bronze layer S3 bucket |
| `s3_bucket_lake_gold_id` | ID of the gold layer S3 bucket |
| `s3_bucket_lake_silver_id` | ID of the silver layer S3 bucket |
| `s3_bucket_landing_raw_id` | ID of the landing raw S3 bucket |

## Usage Instructions

### 1. Initialize

```sh
terraform init
# or
tofu init
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

Verify that the plan shows **no changes** (zero drift) after import.

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```