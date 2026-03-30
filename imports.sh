#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.instance.aws_instance.this i-015dcccda629ac122
terraform import -var-file=environments/terraform.tfvars module.security_group.aws_security_group.this sg-057053456dac1810d
terraform import -var-file=environments/terraform.tfvars 'module.security_group.aws_security_group_rule.this["ssh"]' sg-057053456dac1810d_ingress_tcp_22_22_0.0.0.0/0
terraform import -var-file=environments/terraform.tfvars 'module.security_group.aws_security_group_rule.egress["all"]' sg-057053456dac1810d_egress_all_0_0_0.0.0.0/0