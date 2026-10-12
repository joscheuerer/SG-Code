#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.managed_disk["pr_of_the_galaxy_osdisk"].azurerm_managed_disk.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Compute/disks/pr-of-the-galaxy_OsDisk_1_80e28f24ebe24f8ea996a7737e43faeb'

"$1" import -var-file environments/sg.tfvars 'module.network_interface["pr_of_the_galaxy24_z1"].azurerm_network_interface.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Network/networkInterfaces/pr-of-the-galaxy24_z1'

"$1" import -var-file environments/sg.tfvars 'module.linux_virtual_machine["pr_of_the_galaxy"].azurerm_linux_virtual_machine.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Compute/virtualMachines/pr-of-the-galaxy'

"$1" import -var-file environments/sg.tfvars 'module.key_vault["testmenow"].azurerm_key_vault.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.KeyVault/vaults/testmenow'

"$1" import -var-file environments/sg.tfvars 'module.logic_app_workflow["read_audit_logs"].azurerm_logic_app_workflow.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Logic/workflows/ReadAuditLogs'
