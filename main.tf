module "virtual_network" {
  source = "./modules/virtual_network"

  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.region
  address_space       = var.address_space
  tags                = var.virtual_network_tags
  subnets             = var.subnets
}