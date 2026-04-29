#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.network_security_group.azurerm_network_security_group.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/Adis/providers/Microsoft.Network/networkSecurityGroups/akshat-12-Apr-nsg'

"$1" import -var-file environments/sg.tfvars 'module.network_interface.azurerm_network_interface.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/Adis/providers/Microsoft.Network/networkInterfaces/akshat-12-apr966_z1'

"$1" import -var-file environments/sg.tfvars 'module.managed_disk.azurerm_managed_disk.this["akshat_12_apr_datadisk_0"]' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/Adis/providers/Microsoft.Compute/disks/akshat-12-Apr_DataDisk_0'

"$1" import -var-file environments/sg.tfvars 'module.managed_disk.azurerm_managed_disk.this["akshat_12_apr_osdisk_1_6457833762cd4ee48bf9e0dbee5f3cb8"]' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/Adis/providers/Microsoft.Compute/disks/akshat-12-Apr_OsDisk_1_6457833762cd4ee48bf9e0dbee5f3cb8'

"$1" import -var-file environments/sg.tfvars 'module.virtual_machine.azurerm_virtual_machine.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/ADIS/providers/Microsoft.Compute/virtualMachines/akshat-12-Apr'