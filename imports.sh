#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.vpc.aws_vpc.this vpc-0e278706bd05fe100
terraform import -var-file=environments/terraform.tfvars module.subnet.aws_subnet.this subnet-083c90a8048614a76
terraform import -var-file=environments/terraform.tfvars module.security_group.aws_security_group.this sg-02208ae357c6f1a58
terraform import -var-file=environments/terraform.tfvars 'module.security_group.aws_security_group_rule.this["allow_self"]' sg-02208ae357c6f1a58_ingress_-1_0_0_self_sg-02208ae357c6f1a58
terraform import -var-file=environments/terraform.tfvars 'module.security_group.aws_security_group_rule.egress["allow_all"]' sg-02208ae357c6f1a58_egress_-1_0_0_0.0.0.0/0
terraform import -var-file=environments/terraform.tfvars module.instance.aws_instance.this i-0b86bd1d36a4864dd
terraform import -var-file=environments/terraform.tfvars module.network_interface.aws_network_interface.this eni-0766757b2170188e5
terraform import -var-file=environments/terraform.tfvars module.network_interface.aws_network_interface_attachment.this eni-attach-077754441d8987921