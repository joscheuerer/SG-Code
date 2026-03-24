#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.vpc.aws_vpc.this vpc-0e383da95ac6085aa
terraform import -var-file=environments/terraform.tfvars module.subnet_private_1b.aws_subnet.this subnet-0320b43671a4327ed
terraform import -var-file=environments/terraform.tfvars module.route_table_private_1b.aws_route_table.this rtb-09cc05b9fccf565c9
terraform import -var-file=environments/terraform.tfvars 'module.route_table_private_1b.aws_route_table_association.this["private_1b"]' subnet-0320b43671a4327ed/rtb-09cc05b9fccf565c9
terraform import -var-file=environments/terraform.tfvars module.network_acl.aws_default_network_acl.this acl-0f144cadadcd92531