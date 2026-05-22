#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.ecr_repository.aws_ecr_repository.this' 'sage-agent'