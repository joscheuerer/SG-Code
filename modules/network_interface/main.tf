resource "azurerm_network_interface" "this" {
  name                           = var.name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  accelerated_networking_enabled = var.accelerated_networking_enabled
  ip_forwarding_enabled          = var.ip_forwarding_enabled
  tags                           = var.tags

  dynamic "ip_configuration" {
    for_each = var.ip_configurations
    content {
      name                          = ip_configuration.value.name
      private_ip_address            = ip_configuration.value.private_ip_address
      private_ip_address_version    = ip_configuration.value.private_ip_address_version
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      primary                       = ip_configuration.value.primary
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
      subnet_id                     = ip_configuration.value.subnet_id
    }
  }
}
