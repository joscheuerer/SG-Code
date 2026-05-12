#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_vpc.this' 'vpc-046e4c08ba6dbab3d'
"$1" import -var-file environments/sg.tfvars 'module.subnet["basic_eks_public_eu_central_1b"].aws_subnet.this' 'subnet-02d820ed1bcba116b'
"$1" import -var-file environments/sg.tfvars 'module.subnet["basic_eks_private_eu_central_1b"].aws_subnet.this' 'subnet-03f1fe4b879a8cb8b'
"$1" import -var-file environments/sg.tfvars 'module.subnet["basic_eks_public_eu_central_1a"].aws_subnet.this' 'subnet-046ecb922ddd59f33'
"$1" import -var-file environments/sg.tfvars 'module.subnet["basic_eks_private_eu_central_1c"].aws_subnet.this' 'subnet-06f7eb69ac67a1020'
"$1" import -var-file environments/sg.tfvars 'module.subnet["basic_eks_public_eu_central_1c"].aws_subnet.this' 'subnet-0ae635ee4e44a0eea'
"$1" import -var-file environments/sg.tfvars 'module.subnet["basic_eks_private_eu_central_1a"].aws_subnet.this' 'subnet-0baa6badc21862143'
"$1" import -var-file environments/sg.tfvars 'module.internet_gateway.aws_internet_gateway.this' 'igw-002f3e748d6007f83'
"$1" import -var-file environments/sg.tfvars 'module.route_table["basic_eks_private"].aws_route_table.this' 'rtb-04a97604db2945bae'
"$1" import -var-file environments/sg.tfvars 'module.route_table["basic_eks_public"].aws_route_table.this' 'rtb-0c773fca9a51a4688'
"$1" import -var-file environments/sg.tfvars 'module.route_table["basic_eks_default"].aws_route_table.this' 'rtb-0dbf3bf60fb8df6ac'
"$1" import -var-file environments/sg.tfvars 'module.security_group["basic_eks_cluster"].aws_security_group.this' 'sg-011664c0def65d446'
"$1" import -var-file environments/sg.tfvars 'module.security_group["outpost"].aws_security_group.this' 'sg-024db0d463e8ff59d'
"$1" import -var-file environments/sg.tfvars 'module.security_group["basic_eks_node"].aws_security_group.this' 'sg-0259cfa48eae0addd'
"$1" import -var-file environments/sg.tfvars 'module.security_group["default"].aws_security_group.this' 'sg-06aa81eda599d8a8c'
"$1" import -var-file environments/sg.tfvars 'module.network_acl.aws_default_network_acl.this' 'acl-0da0d8895d381ded4'