#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.iam_instance_profile.aws_iam_instance_profile.this' 'Neha_Private_Runner-runner-instance-profile'
"$1" import -var-file environments/sg.tfvars 'module.key_pair.aws_key_pair.this' 'adis-key-pair'
"$1" import -var-file environments/sg.tfvars 'module.instance["neha_private_runner_private_runner_asg"].aws_instance.this' 'i-REPLACEME_ASG_INSTANCE_ID'
"$1" import -var-file environments/sg.tfvars 'module.instance["community01"].aws_instance.this' 'i-REPLACEME_COMMUNITY01_INSTANCE_ID'
"$1" import -var-file environments/sg.tfvars 'module.network_interface.aws_network_interface.this' 'eni-04f85c5758d32f536'