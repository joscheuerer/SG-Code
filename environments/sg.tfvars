subscription_id = "a97621d8-9158-4681-81b6-38b1222afba4"

windows_virtual_machines = {
  "arunim_host_0" = {
    name                = "arunim-host-0"
    resource_group_name = "arunim-test-resource-group"
    location            = "westeurope"
    size                = "Standard_D2s_v3"
    admin_username      = "arunim"

    network_interface_ids = ["/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Network/networkInterfaces/arunim-host-0-nic"]

    os_disk_name                 = "arunim-host-0_OsDisk_1_498f48af84094a03a30c1a9efe99c319"
    os_disk_caching              = "ReadWrite"
    os_disk_storage_account_type = "StandardSSD_LRS"
    os_disk_create_option        = "FromImage"
    license_type                 = "Windows_Client"

    image_publisher = "microsoftwindowsdesktop"
    image_offer     = "windows-10"
    image_sku       = "win10-22h2-ent-g2"
    image_version   = "latest"

    identity_type = "SystemAssigned"

    boot_diagnostics_enabled     = true
    boot_diagnostics_storage_uri = null

    patch_mode      = "AutomaticByOS"
    assessment_mode = "ImageDefault"

    tags = {
      "cm-resource-parent" = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.DesktopVirtualization/hostpools/arunim-eu-vd-group"
    }

    extensions = {
      "aad_login" = {
        name                       = "aadloginforwindows"
        publisher                  = "Microsoft.Azure.ActiveDirectory"
        type                       = "AADLoginForWindows"
        type_handler_version       = "2.0"
        auto_upgrade_minor_version = true
        settings                   = null
      }
      "dsc" = {
        name                       = "microsoft.powershell.dsc"
        publisher                  = "Microsoft.Powershell"
        type                       = "DSC"
        type_handler_version       = "2.73"
        auto_upgrade_minor_version = true
        settings                   = null
      }
    }
  }
}
