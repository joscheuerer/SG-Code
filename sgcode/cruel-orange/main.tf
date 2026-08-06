module "public_ip" {
  source = "./modules/public_ip"

  allocation_method   = var.public_ip_allocation_method
  ip_version          = var.public_ip_version
  location            = var.location
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  sku                 = var.public_ip_sku
  zones               = var.public_ip_zones
}

module "network_security_group" {
  source = "./modules/network_security_group"

  location            = var.location
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  security_rules      = var.nsg_security_rules
}

module "network_interface" {
  source = "./modules/network_interface"

  accelerated_networking_enabled = var.nic_accelerated_networking_enabled
  ip_config_name                 = var.nic_ip_config_name
  ip_config_primary              = var.nic_ip_config_primary
  ip_forwarding_enabled          = var.nic_ip_forwarding_enabled
  location                       = var.location
  name                           = var.nic_name
  private_ip_address_allocation  = var.nic_private_ip_address_allocation
  private_ip_address_version     = var.nic_private_ip_address_version
  public_ip_address_id           = module.public_ip.id
  resource_group_name            = var.resource_group_name
  subnet_id                      = var.nic_subnet_id
}

module "managed_disk" {
  source = "./modules/managed_disk"

  create_option          = var.managed_disk_create_option
  disk_size_gb           = var.managed_disk_size_gb
  hyper_v_generation     = var.managed_disk_hyper_v_generation
  location               = var.location
  name                   = var.managed_disk_name
  os_type                = var.managed_disk_os_type
  resource_group_name    = var.resource_group_name
  storage_account_type   = var.managed_disk_storage_account_type
  trusted_launch_enabled = var.managed_disk_trusted_launch_enabled
  zone                   = var.managed_disk_zone
}

module "virtual_machine" {
  source = "./modules/virtual_machine"

  admin_username                  = var.vm_admin_username
  boot_diagnostics_enabled        = var.vm_boot_diagnostics_enabled
  boot_diagnostics_storage_uri    = var.vm_boot_diagnostics_storage_uri
  computer_name                   = var.vm_computer_name
  disable_password_authentication = var.vm_disable_password_authentication
  image_offer                     = var.vm_image_offer
  image_publisher                 = var.vm_image_publisher
  image_sku                       = var.vm_image_sku
  image_version                   = var.vm_image_version
  location                        = var.location
  name                            = var.vm_name
  network_interface_ids           = [module.network_interface.id]
  os_disk_caching                 = var.vm_os_disk_caching
  os_disk_create_option           = var.vm_os_disk_create_option
  os_disk_name                    = var.vm_os_disk_name
  os_type                         = var.vm_os_type
  resource_group_name             = var.resource_group_name
  tags                            = var.vm_tags
  vm_size                         = var.vm_size
  zones                           = var.vm_zones
}