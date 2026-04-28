#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars 'module.instances.aws_instance.this["i_000e597ea8aa8260b"]' i-000e597ea8aa8260b
terraform import -var-file=environments/terraform.tfvars 'module.instances.aws_instance.this["sg_runner_new_private_runner_asg"]' i-0073fcf5e556169e8
terraform import -var-file=environments/terraform.tfvars 'module.instances.aws_volume_attachment.this["sg_runner_sda1"]' /dev/sda1:vol-0f5a54343d85c2ca9:i-0073fcf5e556169e8