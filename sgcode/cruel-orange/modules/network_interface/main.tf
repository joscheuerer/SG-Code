resource "azurerm_network_interface" "this" {
  accelerated_networking_enabled = var.accelerated_networking_enabled
  ip_forwarding_enabled          = var.ip_forwarding_enabled
  location                       = var.location
  name                           = var.name
  resource_group_name            = var.resource_group_name

  ip_configuration {
    name                          = var.ip_config_name
    primary                       = var.ip_config_primary
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address_version    = var.private_ip_address_version
    public_ip_address_id          = var.public_ip_address_id
    subnet_id                     = var.subnet_id
  }
}