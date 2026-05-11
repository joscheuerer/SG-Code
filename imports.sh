#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.virtual_network.azurerm_virtual_network.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/azurenetwork/providers/Microsoft.Network/virtualNetworks/azurenetworknet'
"$1" import -var-file environments/sg.tfvars 'module.virtual_network.azurerm_subnet.this["subnet1"]' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/azurenetwork/providers/Microsoft.Network/virtualNetworks/azurenetworknet/subnets/subnet1'
"$1" import -var-file environments/sg.tfvars 'module.virtual_network.azurerm_subnet.this["subnet2"]' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/azurenetwork/providers/Microsoft.Network/virtualNetworks/azurenetworknet/subnets/subnet2'
"$1" import -var-file environments/sg.tfvars 'module.virtual_network.azurerm_subnet.this["subnet3"]' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/azurenetwork/providers/Microsoft.Network/virtualNetworks/azurenetworknet/subnets/subnet3'