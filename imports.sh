#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.iam_instance_profile.aws_iam_instance_profile.this' 'Neha_Private_Runner-runner-instance-profile'
"$1" import -var-file environments/sg.tfvars 'module.key_pair.aws_key_pair.this' 'adis-key-pair'