#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.bronze_ingest_dlq.aws_sqs_queue.this "de-manuel-meireles-bronze-ingest-dlq"