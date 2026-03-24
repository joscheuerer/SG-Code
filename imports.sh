#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars 'module.launch_templates.aws_launch_template.this["one_2025080507384391980000000e"]' lt-0c3ea58540bad72b5
terraform import -var-file=environments/terraform.tfvars 'module.launch_templates.aws_launch_template.this["taher_private_runner"]' lt-00ead3b0f34510223
terraform import -var-file=environments/terraform.tfvars 'module.launch_templates.aws_launch_template.this["sg_qa_org_dash_private_runner_private_runner_20251231115633025100000001"]' lt-06eafafeb45e87f64