#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.config_config_rule.aws_config_config_rule.this' 'dynamodb-table-encrypted-kms'