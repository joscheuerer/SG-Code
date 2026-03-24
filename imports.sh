#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.vpc.aws_vpc.this vpc-024344e8549773d40
terraform import -var-file=environments/terraform.tfvars module.subnet.aws_subnet.this subnet-0b77c0d76befaf70d
terraform import -var-file=environments/terraform.tfvars module.security_group.aws_security_group.this sg-01d2fdbff771e870e
terraform import -var-file=environments/terraform.tfvars 'module.security_group.aws_security_group_rule.this["ssh"]' sg-01d2fdbff771e870e_ingress_tcp_22_22_0.0.0.0/0
terraform import -var-file=environments/terraform.tfvars 'module.security_group.aws_security_group_rule.egress["all"]' sg-01d2fdbff771e870e_egress_all_0_0_0.0.0.0/0
terraform import -var-file=environments/terraform.tfvars module.ebs_volume.aws_ebs_volume.this vol-071ae0d48d3eb4bf0
terraform import -var-file=environments/terraform.tfvars module.instance.aws_instance.this i-0579b199ee172df3d