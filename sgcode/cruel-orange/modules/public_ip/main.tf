resource "azurerm_public_ip" "this" {
  allocation_method   = var.allocation_method
  ip_version          = var.ip_version
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  zones               = var.zones
}