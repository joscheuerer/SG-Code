#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.storage_backend.aws_s3_bucket.this 41n9oxq3-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.storage_backend.aws_s3_bucket_server_side_encryption_configuration.this 41n9oxq3-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.storage_backend.aws_s3_bucket_public_access_block.this 41n9oxq3-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.storage_backend.aws_s3_bucket_ownership_controls.this 41n9oxq3-private-runner-storage-backend
terraform import -var-file=environments/terraform.tfvars module.ebs_volume.aws_ebs_volume.this vol-005b19d24fd787bf5
terraform import -var-file=environments/terraform.tfvars module.platform_api_eni.aws_network_interface.this eni-003b9d893369fab98