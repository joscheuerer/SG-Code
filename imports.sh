#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.private_runner_storage.aws_s3_bucket.this 41n9oxq3-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.private_runner_storage.aws_s3_bucket_ownership_controls.this 41n9oxq3-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.private_runner_storage.aws_s3_bucket_server_side_encryption_configuration.this 41n9oxq3-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.private_runner_storage.aws_s3_bucket_public_access_block.this 41n9oxq3-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.private_runner_storage.aws_s3_bucket_versioning.this 41n9oxq3-private-runner-storage-backend