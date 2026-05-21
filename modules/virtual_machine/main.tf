resource "azurerm_virtual_machine" "this" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  vm_size               = var.vm_size
  network_interface_ids = var.network_interface_ids
  zones                 = var.zones
  tags                  = var.tags

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name              = var.os_disk_name
    caching           = var.os_disk_caching
    create_option     = var.os_disk_create_option
    managed_disk_type = var.os_disk_managed_disk_type
    os_type           = var.os_type
  }

  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = var.disable_password_authentication
  }

  boot_diagnostics {
    enabled     = var.boot_diagnostics_enabled
    storage_uri = var.boot_diagnostics_storage_uri
  }
}