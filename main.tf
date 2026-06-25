module "network_interface" {
  source   = "./modules/network_interface"
  for_each = var.network_interfaces

  name                           = each.value.name
  resource_group_name            = each.value.resource_group_name
  location                       = each.value.location
  accelerated_networking_enabled = each.value.accelerated_networking_enabled
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled
  tags                           = each.value.tags
  ip_configurations              = each.value.ip_configurations
}
