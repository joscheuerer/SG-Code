resource "azurerm_network_interface" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  accelerated_networking_enabled = var.accelerated_networking_enabled
  ip_forwarding_enabled         = var.ip_forwarding_enabled
  tags                          = var.tags

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_version    = "IPv4"
    private_ip_address_allocation = "Dynamic"
    primary                       = true
  }
}