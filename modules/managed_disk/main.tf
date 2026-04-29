resource "azurerm_managed_disk" "this" {
  for_each = var.managed_disks

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  location             = each.value.location
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb
  os_type              = each.value.os_type != "" ? each.value.os_type : null
  tags                 = each.value.tags
}