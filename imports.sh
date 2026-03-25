#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.bucket_2dlru2rs.aws_s3_bucket.this 2dlru2rs-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_2dlru2rs.aws_s3_bucket_public_access_block.this 2dlru2rs-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_2dlru2rs.aws_s3_bucket_ownership_controls.this 2dlru2rs-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_2dlru2rs.aws_s3_bucket_server_side_encryption_configuration.this 2dlru2rs-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_37lxrdhe.aws_s3_bucket.this 37lxrdhe-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_37lxrdhe.aws_s3_bucket_public_access_block.this 37lxrdhe-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_37lxrdhe.aws_s3_bucket_ownership_controls.this 37lxrdhe-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.bucket_37lxrdhe.aws_s3_bucket_server_side_encryption_configuration.this 37lxrdhe-private-runner-storage-backend