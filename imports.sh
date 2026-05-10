#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_vpc.this' 'vpc-00784ac9c64d4472b'
"$1" import -var-file environments/sg.tfvars 'module.subnet.aws_subnet.this' 'subnet-064f42dced8666a63'
"$1" import -var-file environments/sg.tfvars 'module.security_group.aws_security_group.this' 'sg-0adb3e09fe11a19a1'
"$1" import -var-file environments/sg.tfvars 'module.key_pair.aws_key_pair.this' 'private-runner-workshop'
"$1" import -var-file environments/sg.tfvars 'module.iam_instance_profile.aws_iam_instance_profile.this' 'ec2_private_runner_role'
"$1" import -var-file environments/sg.tfvars 'module.ebs_volume.aws_ebs_volume.this' 'vol-0f1e586ceaf10031d'
"$1" import -var-file environments/sg.tfvars 'module.network_interface.aws_network_interface.this' 'eni-0ae0ac032fb68be5b'
"$1" import -var-file environments/sg.tfvars 'module.instance.aws_instance.this' 'i-08663188cc77a9249'