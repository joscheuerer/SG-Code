#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.cloudformation_stack["stackguardian_connector_role"].aws_cloudformation_stack.this' 'StackGuardianConnectorRole'
"$1" import -var-file environments/sg.tfvars 'module.cloudformation_stack["vpc_1"].aws_cloudformation_stack.this' 'vpc-1'
"$1" import -var-file environments/sg.tfvars 'module.cloudformation_stack["vpc_2"].aws_cloudformation_stack.this' 'vpc-2'