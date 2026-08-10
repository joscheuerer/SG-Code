#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars 'module.lambda_edge_roles["0eu096k_ing4i1"].aws_iam_role.this' '0eu096k-ing4i1'
terraform import -var-file=environments/terraform.tfvars 'module.lambda_edge_roles["0eu096k_ing4i1"].aws_iam_role_policy.this["0eu096k_ing4i1_policy"]' '0eu096k-ing4i1:0eu096k-ing4i1-policy'
terraform import -var-file=environments/terraform.tfvars 'module.lambda_edge_roles["1z1sf45_3rieapj"].aws_iam_role.this' '1z1sf45-3rieapj'
terraform import -var-file=environments/terraform.tfvars 'module.lambda_edge_roles["1z1sf45_3rieapj"].aws_iam_role_policy.this["1z1sf45_3rieapj_policy"]' '1z1sf45-3rieapj:1z1sf45-3rieapj-policy'