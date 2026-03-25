#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.lambda_edge_role.aws_iam_role.this "0eu096k-9ci2y0p"
terraform import -var-file=environments/terraform.tfvars 'module.lambda_edge_role.aws_iam_role_policy.this["policy_1"]' "0eu096k-9ci2y0p:0eu096k-9ci2y0p-policy"