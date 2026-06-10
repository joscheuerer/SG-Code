#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_vpc.this' 'vpc-07ab137e2cc49c068'

"$1" import -var-file environments/sg.tfvars 'module.subnet["approvalv2_dev2_privatesubnet1"].aws_subnet.this' 'subnet-03e7a88db06b8263a'
"$1" import -var-file environments/sg.tfvars 'module.subnet["approvalv2_dev2_publicsubnet1"].aws_subnet.this' 'subnet-047686cbdc216e5a1'
"$1" import -var-file environments/sg.tfvars 'module.subnet["approvalv2_dev2_publicsubnet2"].aws_subnet.this' 'subnet-07971bba1b7a42270'
"$1" import -var-file environments/sg.tfvars 'module.subnet["approvalv2_dev2_privatesubnet2"].aws_subnet.this' 'subnet-0ac80964ef0acb99c'
"$1" import -var-file environments/sg.tfvars 'module.subnet["approvalv2_dev2_publicsubnet3"].aws_subnet.this' 'subnet-0b2bfeab9b9600478'

"$1" import -var-file environments/sg.tfvars 'module.internet_gateway.aws_internet_gateway.this' 'igw-04417c76d78155e2e'

"$1" import -var-file environments/sg.tfvars 'module.route_table["approvalv2_dev2_publicrt"].aws_route_table.this' 'rtb-08004bb274b987779'
"$1" import -var-file environments/sg.tfvars 'module.route_table["approvalv2_dev2_privatert"].aws_route_table.this' 'rtb-0f7772eb68094bb1e'
"$1" import -var-file environments/sg.tfvars 'module.route_table["aws_route_table_2"].aws_route_table.this' 'rtb-0a8623f5c98b5f651'

"$1" import -var-file environments/sg.tfvars 'module.security_group["approvalv2_dev2_sc1"].aws_security_group.this' 'sg-016209b903a312283'
"$1" import -var-file environments/sg.tfvars 'module.security_group["default"].aws_security_group.this' 'sg-08ddee24b0704317a'

"$1" import -var-file environments/sg.tfvars 'module.network_acl["approvalv2_dev2_nacl"].aws_default_network_acl.this' 'acl-002a010e6f61e9ae6'

"$1" import -var-file environments/sg.tfvars 'module.key_pair["ansible_instance_key"].aws_key_pair.this' 'ansible-instance-key'
