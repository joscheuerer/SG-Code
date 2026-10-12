resource "azurerm_managed_disk" "this" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  location               = var.location
  storage_account_type   = var.storage_account_type
  disk_size_gb           = var.disk_size_gb
  create_option          = var.create_option
  os_type                = var.os_type
  hyper_v_generation     = var.hyper_v_generation
  trusted_launch_enabled = var.trusted_launch_enabled
  zone                   = var.zone
  tags                   = var.tags

  lifecycle {
    ignore_changes = [create_option, image_reference_id]
  }
}
