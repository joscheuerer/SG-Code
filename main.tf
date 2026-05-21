module "public_ip" {
  source              = "./modules/public_ip"
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  zones               = var.public_ip_zones
}

module "network_security_group" {
  source              = "./modules/network_security_group"
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
  security_rules      = var.nsg_security_rules
}

module "network_interface" {
  source                        = "./modules/network_interface"
  name                          = var.nic_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  accelerated_networking_enabled = var.nic_accelerated_networking_enabled
  ip_forwarding_enabled         = var.nic_ip_forwarding_enabled
  ip_configuration_name         = var.nic_ip_configuration_name
  subnet_id                     = var.nic_subnet_id
  private_ip_address_allocation = var.nic_private_ip_address_allocation
  private_ip_address_version    = var.nic_private_ip_address_version
  public_ip_address_id          = module.public_ip.id
  ip_configuration_primary      = var.nic_ip_configuration_primary
}

module "managed_disk" {
  source                 = "./modules/managed_disk"
  name                   = var.managed_disk_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  storage_account_type   = var.managed_disk_storage_account_type
  create_option          = var.managed_disk_create_option
  disk_size_gb           = var.managed_disk_size_gb
  os_type                = var.managed_disk_os_type
  hyper_v_generation     = var.managed_disk_hyper_v_generation
  trusted_launch_enabled = var.managed_disk_trusted_launch_enabled
  zone                   = var.managed_disk_zone
  image_reference_id     = var.managed_disk_image_reference_id
}

module "virtual_machine" {
  source                          = "./modules/virtual_machine"
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  vm_size                         = var.vm_size
  network_interface_ids           = [module.network_interface.id]
  zones                           = var.vm_zones
  tags                            = var.vm_tags
  image_publisher                 = var.vm_image_publisher
  image_offer                     = var.vm_image_offer
  image_sku                       = var.vm_image_sku
  image_version                   = var.vm_image_version
  os_disk_name                    = var.vm_os_disk_name
  os_disk_caching                 = var.vm_os_disk_caching
  os_disk_create_option           = var.vm_os_disk_create_option
  os_disk_managed_disk_type       = var.vm_os_disk_managed_disk_type
  os_type                         = var.vm_os_type
  computer_name                   = var.vm_computer_name
  admin_username                  = var.vm_admin_username
  disable_password_authentication = var.vm_disable_password_authentication
  boot_diagnostics_enabled        = var.vm_boot_diagnostics_enabled
  boot_diagnostics_storage_uri    = var.vm_boot_diagnostics_storage_uri
}