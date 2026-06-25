#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.network_interface.azurerm_network_interface.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Network/networkInterfaces/arunim-host-0-nic'