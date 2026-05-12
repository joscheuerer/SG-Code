resource "azurerm_managed_disk" "this" {
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  hyper_v_generation   = var.hyper_v_generation
  location             = var.location
  name                 = var.name
  os_type              = var.os_type
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  trusted_launch_enabled = var.trusted_launch_enabled
  zone                 = var.zone
}