module "network_security_group" {
  source              = "./modules/network_security_group"
  name                = var.nsg_name
  resource_group_name = var.nsg_resource_group_name
  location            = var.region
  tags                = var.nsg_tags
}

module "network_interface" {
  source                         = "./modules/network_interface"
  name                           = var.nic_name
  resource_group_name            = var.nic_resource_group_name
  location                       = var.region
  accelerated_networking_enabled = var.nic_accelerated_networking_enabled
  ip_forwarding_enabled          = var.nic_ip_forwarding_enabled
  subnet_id                      = var.nic_subnet_id
  tags                           = var.nic_tags
}

module "managed_disk" {
  source        = "./modules/managed_disk"
  managed_disks = var.managed_disks
}

module "virtual_machine" {
  source                          = "./modules/virtual_machine"
  name                            = var.vm_name
  resource_group_name             = var.vm_resource_group_name
  location                        = var.region
  vm_size                         = var.vm_size
  network_interface_ids           = [module.network_interface.id]
  zones                           = var.vm_zones
  image_publisher                 = var.vm_image_publisher
  image_offer                     = var.vm_image_offer
  image_sku                       = var.vm_image_sku
  image_version                   = var.vm_image_version
  os_disk_name                    = var.vm_os_disk_name
  os_disk_caching                 = var.vm_os_disk_caching
  os_type                         = var.vm_os_type
  data_disk_name                  = var.vm_data_disk_name
  data_disk_size_gb               = var.vm_data_disk_size_gb
  data_disk_managed_disk_id       = module.managed_disk.ids["akshat_12_apr_datadisk_0"]
  data_disk_managed_disk_type     = var.vm_data_disk_managed_disk_type
  computer_name                   = var.vm_computer_name
  admin_username                  = var.vm_admin_username
  disable_password_authentication = var.vm_disable_password_authentication
  ssh_public_key_data             = var.vm_ssh_public_key_data
  tags                            = var.vm_tags
}