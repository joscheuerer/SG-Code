module "network_interface" {
  source = "./modules/network_interface"

  accelerated_networking_enabled = var.accelerated_networking_enabled
  ip_configuration_name          = var.ip_configuration_name
  ip_configuration_primary       = var.ip_configuration_primary
  ip_forwarding_enabled          = var.ip_forwarding_enabled
  location                       = var.location
  name                           = var.name
  private_ip_address             = var.private_ip_address
  private_ip_address_allocation  = var.private_ip_address_allocation
  private_ip_address_version     = var.private_ip_address_version
  public_ip_address_id           = var.public_ip_address_id
  resource_group_name            = var.resource_group_name
  subnet_id                      = var.subnet_id
  tags                           = var.tags
}