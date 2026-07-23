#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_vpc.this[0]' 'vpc-00784ac9c64d4472b'
"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_subnet.public[0]' 'subnet-064f42dced8666a63'
"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_subnet.private[0]' 'subnet-070f56eea88d75567'
"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_internet_gateway.this[0]' 'igw-0c91604913106ca0a'
"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_route_table.public[0]' 'rtb-0b8ce2f7a35a31c0b'
"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_route_table.private[0]' 'rtb-05b1d7216fb16a923'
"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_default_route_table.default[0]' 'rtb-0abac1d73449000e6'
"$1" import -var-file environments/sg.tfvars 'module.cdk_assets_bucket.aws_s3_bucket.this[0]' 'cdk-hnb659fds-assets-470037505301-us-east-1'
"$1" import -var-file environments/sg.tfvars 'module.private_runner_storage_bucket.aws_s3_bucket.this[0]' 'p0w7vdek-private-runner-storage-backend'
"$1" import -var-file environments/sg.tfvars 'module.instance.aws_instance.this' 'i-08663188cc77a9249'
"$1" import -var-file environments/sg.tfvars 'module.network_interface.aws_network_interface.this' 'eni-0ae0ac032fb68be5b'
"$1" import -var-file environments/sg.tfvars 'module.security_group_launch_wizard.aws_security_group.this' 'sg-08893890a8ca9245e'
"$1" import -var-file environments/sg.tfvars 'module.security_group_default.aws_security_group.this' 'sg-0991e063bf037c60c'
"$1" import -var-file environments/sg.tfvars 'module.security_group_launch_wizard_1.aws_security_group.this' 'sg-0adb3e09fe11a19a1'
"$1" import -var-file environments/sg.tfvars 'module.network_acl.aws_network_acl.this' 'acl-03c5263da4e5170f2'