#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.vpc.aws_vpc.this vpc-092e2c24e01e5e088
terraform import -var-file=environments/terraform.tfvars 'module.subnets.aws_subnet.this["sg_vpc_xxklkl_public_eu_central_1a"]' subnet-00814073aedec329c
terraform import -var-file=environments/terraform.tfvars 'module.subnets.aws_subnet.this["sg_vpc_xxklkl_public_eu_central_1b"]' subnet-0ee0208d57ee73aac
terraform import -var-file=environments/terraform.tfvars 'module.subnets.aws_subnet.this["sg_vpc_xxklkl_private_eu_central_1a"]' subnet-0f718074cc8854e5f
terraform import -var-file=environments/terraform.tfvars 'module.subnets.aws_subnet.this["sg_vpc_xxklkl_private_eu_central_1b"]' subnet-0fe77d1885a2fb2d2
terraform import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table.this["sg_vpc_xxklkl_private_eu_central_1b"]' rtb-021f2fa9a3a9f11bc
terraform import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table.this["sg_vpc_xxklkl_private_eu_central_1a"]' rtb-0b299ab953d8b76b2
terraform import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table.this["sg_vpc_xxklkl_default"]' rtb-0b7a0362615bab331
terraform import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table.this["sg_vpc_xxklkl_public"]' rtb-0cecfd6350f50ed89
terraform import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route.this["public_internet"]' rtb-0cecfd6350f50ed89_0.0.0.0/0
terraform import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table_association.this["private_1b"]' rtbassoc-0834e3b683e5c3776
terraform import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table_association.this["private_1a"]' rtbassoc-02450b792763ac005
terraform import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table_association.this["public_1a"]' rtbassoc-0d6e4d735821f3415
terraform import -var-file=environments/terraform.tfvars 'module.route_tables.aws_route_table_association.this["public_1b"]' rtbassoc-01c225b1a8d6711c3
terraform import -var-file=environments/terraform.tfvars module.internet_gateway.aws_internet_gateway.this igw-0dff0c91fbd2eb568
terraform import -var-file=environments/terraform.tfvars 'module.security_groups.aws_security_group.this["default"]' sg-03c0a7c3bd2dfb7fe
terraform import -var-file=environments/terraform.tfvars 'module.security_groups.aws_security_group.this["vpc_092e2c24e01e5e088_20251126171749264400000001"]' sg-0dcab0786817f9fa2
terraform import -var-file=environments/terraform.tfvars module.network_acl.aws_network_acl.this acl-0b97d195e99e4a95f
terraform import -var-file=environments/terraform.tfvars 'module.network_acl.aws_network_acl_rule.this["egress_100"]' acl-0b97d195e99e4a95f:100:true:all
terraform import -var-file=environments/terraform.tfvars 'module.network_acl.aws_network_acl_rule.this["egress_32767"]' acl-0b97d195e99e4a95f:32767:true:all
terraform import -var-file=environments/terraform.tfvars 'module.network_acl.aws_network_acl_rule.this["ingress_100"]' acl-0b97d195e99e4a95f:100:false:all
terraform import -var-file=environments/terraform.tfvars 'module.network_acl.aws_network_acl_rule.this["ingress_32767"]' acl-0b97d195e99e4a95f:32767:false:all