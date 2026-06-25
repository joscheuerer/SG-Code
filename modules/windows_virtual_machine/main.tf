resource "azurerm_windows_virtual_machine" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = var.network_interface_ids

  os_disk {
    name                 = var.os_disk_name
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  identity {
    type = var.identity_type
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_enabled ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics_storage_uri
    }
  }

  patch_mode            = var.patch_mode
  patch_assessment_mode = var.assessment_mode
  license_type          = var.license_type

  additional_capabilities {
    ultra_ssd_enabled   = var.ultra_ssd_enabled
    hibernation_enabled = var.hibernation_enabled
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [admin_password]
  }
}

resource "azurerm_virtual_machine_extension" "this" {
  for_each = var.extensions

  name                       = each.value.name
  virtual_machine_id         = azurerm_windows_virtual_machine.this.id
  publisher                  = each.value.publisher
  type                       = each.value.type
  type_handler_version       = each.value.type_handler_version
  auto_upgrade_minor_version = each.value.auto_upgrade_minor_version

  settings = each.value.settings

  lifecycle {
    ignore_changes = [settings, protected_settings]
  }
}
