module "virtual_network" {
  source = "./modules/virtual_network"

  address_space       = ["10.0.0.0/16"]
  location            = var.region
  name                = "lufthansavnet"
  resource_group_name = "lufthansa"
  subnets             = var.subnets
  tags                = { "ENV" = "demo" }
}