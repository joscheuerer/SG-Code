#!/bin/sh
set -e
"$1" import -var-file environments/sg.tfvars 'module.internet_gateway["basic_eks"].aws_internet_gateway.this' 'igw-002f3e748d6007f83'
"$1" import -var-file environments/sg.tfvars 'module.internet_gateway["vpc_rp"].aws_internet_gateway.this' 'igw-00e31885391627f42'
