#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.ubuntu_debugging.aws_instance.this i-08f2821d46fa1cbef
terraform import -var-file=environments/terraform.tfvars module.ubuntu_debugging.aws_ebs_volume.this vol-00187254b9eb74e28