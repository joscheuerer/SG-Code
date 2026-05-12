#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.virtual_network.azurerm_virtual_network.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/pbb-rg/providers/Microsoft.Network/virtualNetworks/pbbvnet'
"$1" import -var-file environments/sg.tfvars 'module.network_security_group["pbb_vm_nsg"].azurerm_network_security_group.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/pbb-rg/providers/Microsoft.Network/networkSecurityGroups/pbb-vm-nsg'
"$1" import -var-file environments/sg.tfvars 'module.network_security_group["private_runner_1_nsg"].azurerm_network_security_group.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/private-runner-1-nsg'
"$1" import -var-file environments/sg.tfvars 'module.subnet["subnet2"].azurerm_subnet.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/pbb-rg/providers/Microsoft.Network/virtualNetworks/pbbvnet/subnets/subnet2'
"$1" import -var-file environments/sg.tfvars 'module.subnet["subnet1"].azurerm_subnet.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/pbb-rg/providers/Microsoft.Network/virtualNetworks/pbbvnet/subnets/subnet1'
"$1" import -var-file environments/sg.tfvars 'module.subnet["subnet3"].azurerm_subnet.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/pbb-rg/providers/Microsoft.Network/virtualNetworks/pbbvnet/subnets/subnet3'