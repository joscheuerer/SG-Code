module "virtual_network" {
  source = "./modules/virtual_network"

  name                = var.virtual_network_name
  resource_group_name = var.virtual_network_resource_group_name
  location            = var.region
  address_space       = var.virtual_network_address_space
  tags                = var.virtual_network_tags
}

module "network_security_group" {
  source   = "./modules/network_security_group"
  for_each = var.network_security_groups

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = var.region
  security_rules      = each.value.security_rules
  tags                = each.value.tags
}

module "subnet" {
  source   = "./modules/subnet"
  for_each = var.subnets

  name                              = each.value.name
  resource_group_name               = each.value.resource_group_name
  virtual_network_name              = module.virtual_network.name
  address_prefixes                  = each.value.address_prefixes
  delegation                        = each.value.delegation
  service_endpoints                 = each.value.service_endpoints
  private_endpoint_network_policies = each.value.private_endpoint_network_policies
}