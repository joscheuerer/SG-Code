#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.ebs_csi_policy.aws_iam_policy.this ANPA3QEAOIQD2U5I35WY6