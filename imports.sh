#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.bucket_7beoi78w.aws_s3_bucket.this 7beoi78w-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_7beoi78w.aws_s3_bucket_ownership_controls.this 7beoi78w-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_7beoi78w.aws_s3_bucket_public_access_block.this 7beoi78w-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_7beoi78w.aws_s3_bucket_server_side_encryption_configuration.this 7beoi78w-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_7ungwu6v.aws_s3_bucket.this 7ungwu6v-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_7ungwu6v.aws_s3_bucket_ownership_controls.this 7ungwu6v-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_7ungwu6v.aws_s3_bucket_public_access_block.this 7ungwu6v-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_7ungwu6v.aws_s3_bucket_server_side_encryption_configuration.this 7ungwu6v-private-runner-storage-backend