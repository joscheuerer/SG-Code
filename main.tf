module "managed_disk" {
  source   = "./modules/managed_disk"
  for_each = var.managed_disks

  name                   = each.value.name
  resource_group_name    = each.value.resource_group_name
  location               = each.value.location
  storage_account_type   = each.value.storage_account_type
  disk_size_gb           = each.value.disk_size_gb
  create_option          = each.value.create_option
  hyper_v_generation     = each.value.hyper_v_generation
  trusted_launch_enabled = each.value.trusted_launch_enabled
  zone                   = each.value.zone
  os_type                = each.value.os_type
  tags                   = each.value.tags
}

module "network_interface" {
  source   = "./modules/network_interface"
  for_each = var.network_interfaces

  name                           = each.value.name
  resource_group_name            = each.value.resource_group_name
  location                       = each.value.location
  ip_configurations              = each.value.ip_configurations
  accelerated_networking_enabled = each.value.accelerated_networking_enabled
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled
  network_security_group_id      = each.value.network_security_group_id
  tags                           = each.value.tags
}

module "linux_virtual_machine" {
  source   = "./modules/linux_virtual_machine"
  for_each = var.linux_virtual_machines

  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids           = each.value.network_interface_ids
  zone                            = each.value.zone
  os_disk_name                    = each.value.os_disk_name
  os_disk_caching                 = each.value.os_disk_caching
  os_disk_storage_account_type    = each.value.os_disk_storage_account_type
  source_image_publisher          = each.value.source_image_publisher
  source_image_offer              = each.value.source_image_offer
  source_image_sku                = each.value.source_image_sku
  source_image_version            = each.value.source_image_version
  identity_type                   = each.value.identity_type
  vtpm_enabled                    = each.value.vtpm_enabled
  secure_boot_enabled             = each.value.secure_boot_enabled
  tags                            = each.value.tags
}

module "key_vault" {
  source   = "./modules/key_vault"
  for_each = var.key_vaults

  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  tenant_id                       = each.value.tenant_id
  sku_name                        = each.value.sku_name
  enabled_for_deployment          = each.value.enabled_for_deployment
  enabled_for_disk_encryption     = each.value.enabled_for_disk_encryption
  enabled_for_template_deployment = each.value.enabled_for_template_deployment
  purge_protection_enabled        = each.value.purge_protection_enabled
  soft_delete_retention_days      = each.value.soft_delete_retention_days
  enable_rbac_authorization       = each.value.enable_rbac_authorization
  tags                            = each.value.tags
}

module "logic_app_workflow" {
  source   = "./modules/logic_app_workflow"
  for_each = var.logic_app_workflows

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  workflow_schema     = each.value.workflow_schema
  workflow_version    = each.value.workflow_version
  enabled             = each.value.enabled
  parameters          = each.value.parameters
  tags                = each.value.tags
  sg_api_key          = var.sg_api_key
}
