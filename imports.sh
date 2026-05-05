#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.vpc_eks.aws_internet_gateway.this[0]' 'igw-00feab76abd7ba8e7'