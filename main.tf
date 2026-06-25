module "windows_virtual_machine" {
  source   = "./modules/windows_virtual_machine"
  for_each = var.windows_virtual_machines

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = var.vm_admin_passwords[each.key]

  network_interface_ids        = each.value.network_interface_ids
  os_disk_name                 = each.value.os_disk_name
  os_disk_caching              = each.value.os_disk_caching
  os_disk_storage_account_type = each.value.os_disk_storage_account_type
  os_disk_create_option        = each.value.os_disk_create_option
  license_type                 = each.value.license_type
  ultra_ssd_enabled            = each.value.ultra_ssd_enabled
  hibernation_enabled          = each.value.hibernation_enabled

  image_publisher = each.value.image_publisher
  image_offer     = each.value.image_offer
  image_sku       = each.value.image_sku
  image_version   = each.value.image_version

  identity_type = each.value.identity_type

  boot_diagnostics_enabled     = each.value.boot_diagnostics_enabled
  boot_diagnostics_storage_uri = each.value.boot_diagnostics_storage_uri

  patch_mode      = each.value.patch_mode
  assessment_mode = each.value.assessment_mode

  tags = each.value.tags

  extensions = each.value.extensions
}
