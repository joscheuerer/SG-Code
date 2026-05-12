#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.virtual_machine.azurerm_virtual_machine.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/test/providers/Microsoft.Compute/virtualMachines/private-runner-sg-azure2'
"$1" import -var-file environments/sg.tfvars 'module.managed_disk.azurerm_managed_disk.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/test/providers/Microsoft.Compute/disks/private-runner-sg-azure2_OsDisk_1_17de18156ae54efd9060319f1d9c535e'
"$1" import -var-file environments/sg.tfvars 'module.network_interface.azurerm_network_interface.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/test/providers/Microsoft.Network/networkInterfaces/private-runner-sg-azure2113_z1'
"$1" import -var-file environments/sg.tfvars 'module.network_security_group.azurerm_network_security_group.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/test/providers/Microsoft.Network/networkSecurityGroups/private-runner-sg-azure2-nsg'
"$1" import -var-file environments/sg.tfvars 'module.public_ip.azurerm_public_ip.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/test/providers/Microsoft.Network/publicIPAddresses/private-runner-sg-azure2-ip'