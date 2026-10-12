resource "azurerm_linux_virtual_machine" "this" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.admin_username
  disable_password_authentication = var.disable_password_authentication
  network_interface_ids           = var.network_interface_ids
  zone                            = var.zone
  tags                            = var.tags

  os_disk {
    name                 = var.os_disk_name
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type = var.identity_type
    }
  }

  vtpm_enabled        = var.vtpm_enabled
  secure_boot_enabled = var.secure_boot_enabled

  additional_capabilities {
    ultra_ssd_enabled   = false
    hibernation_enabled = false
  }

  boot_diagnostics {}

  lifecycle {
    ignore_changes = [admin_password]
  }
}
