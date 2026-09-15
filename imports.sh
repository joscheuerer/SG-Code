#!/bin/sh
set -e
"$1" import -var-file environments/sg.tfvars 'module.instance["test_instance"].aws_instance.this' 'i-0883c858a214d5bf9'
