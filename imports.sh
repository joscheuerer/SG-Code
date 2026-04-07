#!/bin/sh
set -e

TF_BIN_PATH="$1"
[ -z "$TF_BIN_PATH" ] && { echo "Usage: $0 <tf-bin-path>" >&2; exit 1; }

"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.vpc.aws_vpc.this' 'vpc-024344e8549773d40'
"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.subnet.aws_subnet.this' 'subnet-0b77c0d76befaf70d'
"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.security_group.aws_security_group.this' 'sg-04211bd5ce13e32c0'
"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.security_group.aws_vpc_security_group_ingress_rule.this["ssh"]' 'sgr-0c6ad9beaa0c0f4f1'
"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.security_group.aws_vpc_security_group_egress_rule.this["all"]' 'sgr-0bbe8177077664b76'
"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.ebs_volume.aws_ebs_volume.this' 'vol-0ab806952aadb38d3'
"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.instance.aws_instance.this' 'i-007e6212f82fd1d38'