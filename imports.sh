#!/bin/sh
set -e

TF_BIN_PATH="$1"
[ -z "$TF_BIN_PATH" ] && { echo "Usage: $0 <tf-bin-path>" >&2; exit 1; }

"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.virtual_network.azurerm_virtual_network.this' 'lufthansavnet'
"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.virtual_network.azurerm_subnet.this["akssubnet"]' 'akssubnet'
"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.virtual_network.azurerm_subnet.this["appsubnet"]' 'appsubnet'
"$TF_BIN_PATH" import -var-file=environments/terraform.tfvars 'module.virtual_network.azurerm_subnet.this["dbsubnet"]' 'dbsubnet'