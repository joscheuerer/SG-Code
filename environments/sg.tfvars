region                              = "eastus"
virtual_network_name                = "pbbvnet"
virtual_network_resource_group_name = "pbb-rg"
virtual_network_address_space       = ["10.0.0.0/16", "10.1.0.0/16"]

virtual_network_tags = {
  ENV      = "test"
  modified = "manually"
}

network_security_groups = {
  pbb_vm_nsg = {
    name                = "pbb-vm-nsg"
    resource_group_name = "pbb-rg"
    security_rules      = []
    tags = {
      source = "terraform"
    }
  }
  private_runner_1_nsg = {
    name                = "private-runner-1-nsg"
    resource_group_name = "test"
    security_rules = [
      {
        name                       = "SSH"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "AllowAnyHTTPInbound"
        priority                   = 310
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
    tags = {}
  }
}

subnets = {
  subnet2 = {
    name                              = "subnet2"
    resource_group_name               = "pbb-rg"
    address_prefixes                  = ["10.0.2.0/24"]
    private_endpoint_network_policies = "Enabled"
    delegation                        = []
    service_endpoints                 = []
  }
  subnet1 = {
    name                              = "subnet1"
    resource_group_name               = "pbb-rg"
    address_prefixes                  = ["10.0.1.0/24"]
    private_endpoint_network_policies = "Enabled"
    delegation = [
      {
        name = "Microsoft.ApiManagement.service"
        service_delegation = {
          name = "Microsoft.ApiManagement/service"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          ]
        }
      }
    ]
    service_endpoints = ["Microsoft.AzureActiveDirectory"]
  }
  subnet3 = {
    name                              = "subnet3"
    resource_group_name               = "pbb-rg"
    address_prefixes                  = ["10.0.3.0/24"]
    private_endpoint_network_policies = "Enabled"
    delegation = [
      {
        name = "Microsoft.Codespaces.plans"
        service_delegation = {
          name = "Microsoft.Codespaces/plans"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
          ]
        }
      }
    ]
    service_endpoints = ["Microsoft.AzureCosmosDB"]
  }
}