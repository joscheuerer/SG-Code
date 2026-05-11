#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.key_pair.aws_key_pair.this' 'private-runner-workshop'
"$1" import -var-file environments/sg.tfvars 'module.iam_instance_profile.aws_iam_instance_profile.this' 'ec2_private_runner_role'
"$1" import -var-file environments/sg.tfvars 'module.instance.aws_instance.this' 'i-08663188cc77a9249'