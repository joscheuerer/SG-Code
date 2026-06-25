#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars \
  'module.windows_virtual_machine["arunim_host_0"].azurerm_windows_virtual_machine.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Compute/virtualMachines/arunim-host-0'

"$1" import -var-file environments/sg.tfvars \
  'module.windows_virtual_machine["arunim_host_0"].azurerm_virtual_machine_extension.this["aad_login"]' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Compute/virtualMachines/arunim-host-0/extensions/aadloginforwindows'

"$1" import -var-file environments/sg.tfvars \
  'module.windows_virtual_machine["arunim_host_0"].azurerm_virtual_machine_extension.this["dsc"]' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Compute/virtualMachines/arunim-host-0/extensions/microsoft.powershell.dsc'
