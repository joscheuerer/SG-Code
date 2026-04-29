region               = "germanywestcentral"
resource_group_name  = "sg-rg-full"
virtual_network_name = "full-stack-vnet"
address_space        = ["10.0.0.0/16"]

virtual_network_tags = {
  Project     = "SnipeIT-FullStack"
  Environment = "dev"
  ManagedBy   = "Terraform"
}

subnets = {
  app = {
    address_prefixes                  = ["10.0.2.0/24"]
    private_endpoint_network_policies = "Enabled"
  }
}