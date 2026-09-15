#!/bin/sh
set -e
"$1" import -var-file environments/sg.tfvars 'module.instance["sg_vm_heidelberg_demo"].aws_instance.this' 'i-0229fa4465891868d'
