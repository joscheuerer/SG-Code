#!/bin/sh
set -e

tofu1.11.2 import -var-file=environments/terraform.tfvars module.vpc.aws_vpc.this vpc-072700b7336ad0752
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.subnets.aws_subnet.this["subnetname1"]' subnet-0587478b1e052ce6a
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.subnets.aws_subnet.this["subnetname2"]' subnet-03a230a9d1b8b9036
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.subnets.aws_subnet.this["privatesubnetname1"]' subnet-0e4b2d1e5907c198e
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.subnets.aws_subnet.this["privatesubnetname2"]' subnet-0fedab5812fadb197
tofu1.11.2 import -var-file=environments/terraform.tfvars module.internet_gateway.aws_internet_gateway.this igw-081452c458c193e5e
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table.this["do_not_delete_public"]' rtb-0586c5f005575838b
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table.this["do_not_delete_default"]' rtb-087abcdcb9e173b0c
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table.this["do_not_delete_private_eu_central_1a"]' rtb-0cf4f2a86fa45c666
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table.this["do_not_delete_private_eu_central_1b"]' rtb-0b2b15707a5f8b488
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route.this["public_internet"]' rtb-0586c5f005575838b_0.0.0.0/0
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table_association.this["public_subnetname1"]' rtbassoc-0b673d7e089d58b49
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table_association.this["public_subnetname2"]' rtbassoc-0766bfc06ccb64a6f
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table_association.this["private_privatesubnetname1"]' rtbassoc-04b68a71092aa1cbd
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table_association.this["private_privatesubnetname2"]' rtbassoc-0b2baf38b801025c9
tofu1.11.2 import -var-file=environments/terraform.tfvars module.security_group.aws_security_group.this sg-080c3f9f0365043a9
tofu1.11.2 import -var-file=environments/terraform.tfvars module.network_acl.aws_network_acl.this acl-0210dae0f5062d949
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.network_acl.aws_network_acl_rule.this["egress_100"]' acl-0210dae0f5062d949:100:true:all:0.0.0.0/0
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.network_acl.aws_network_acl_rule.this["egress_101"]' acl-0210dae0f5062d949:101:true:all:::/0
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.network_acl.aws_network_acl_rule.this["ingress_100"]' acl-0210dae0f5062d949:100:false:all:0.0.0.0/0
tofu1.11.2 import -var-file=environments/terraform.tfvars 'module.network_acl.aws_network_acl_rule.this["ingress_101"]' acl-0210dae0f5062d949:101:false:all:::/0