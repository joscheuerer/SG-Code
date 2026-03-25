#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars 'module.ebs_volumes.aws_ebs_volume.this["vol_006016473226c20a1"]' vol-006016473226c20a1
terraform import -var-file=environments/terraform.tfvars 'module.ebs_volumes.aws_ebs_volume.this["vol_00604ce9672c2753c"]' vol-00604ce9672c2753c
terraform import -var-file=environments/terraform.tfvars 'module.ebs_volumes.aws_ebs_volume.this["vol_007e128ed703166ca"]' vol-007e128ed703166ca