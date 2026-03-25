# sqs-bronze-ingest-dlq

SQS dead letter queue for bronze layer data ingestion

## Architecture

This stack provisions an SQS queue configured as a dead letter queue for the bronze layer of a medallion architecture data lake. The queue uses SQS-managed server-side encryption and is configured with a 14-day message retention period.

## Modules

### sqs_queue

Manages SQS queue configuration with customizable parameters for delay, message size, retention, encryption, and visibility timeout.

**Resources:**
- `aws_sqs_queue.this` - SQS queue resource

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region for resource deployment | - |

## Outputs

| Name | Description |
|------|-------------|
| dlq_arn | ARN of the bronze ingest dead letter queue |
| dlq_url | URL of the bronze ingest dead letter queue |

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

The bronze ingest DLQ is configured with:
- **Message Retention**: 14 days (1,209,600 seconds)
- **Max Message Size**: 256 KB (262,144 bytes)
- **Visibility Timeout**: 30 seconds
- **Encryption**: SQS-managed SSE enabled
- **Queue Type**: Standard (non-FIFO)
- **Delivery Delay**: None (0 seconds)

## Tags

All resources are tagged with:
- Project: data-lake
- ManagedBy: terraform
- Architecture: medallion
- Environment: de-manuel-meireles
- Purpose: dead-letter-queue
- Layer: bronze
- Name: de-manuel-meireles-bronze-ingest-dlq