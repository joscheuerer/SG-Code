resource "azurerm_virtual_machine" "this" {
  location                = var.location
  name                    = var.name
  network_interface_ids   = var.network_interface_ids
  resource_group_name     = var.resource_group_name
  tags                    = var.tags
  vm_size                 = var.vm_size
  zones                   = var.zones

  boot_diagnostics {
    enabled     = var.boot_diagnostics_enabled
    storage_uri = var.boot_diagnostics_storage_uri
  }

  os_profile {
    admin_username = var.admin_username
    computer_name  = var.computer_name
  }

  os_profile_linux_config {
    disable_password_authentication = var.disable_password_authentication
  }

  storage_image_reference {
    offer     = var.image_offer
    publisher = var.image_publisher
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    caching       = var.os_disk_caching
    create_option = var.os_disk_create_option
    name          = var.os_disk_name
    os_type       = var.os_type
  }
}