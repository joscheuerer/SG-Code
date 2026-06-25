subscription_id = "a97621d8-9158-4681-81b6-38b1222afba4"

network_interfaces = {
  "arunim_host_0_nic" = {
    name                           = "arunim-host-0-nic"
    resource_group_name            = "arunim-test-resource-group"
    location                       = "westeurope"
    accelerated_networking_enabled = false
    ip_forwarding_enabled          = false
    tags = {
      "cm-resource-parent" = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourcegroups/arunim-test-resource-group/providers/Microsoft.DesktopVirtualization/hostpools/arunim-eu-vd-group"
    }
    ip_configurations = [
      {
        name                          = "ipconfig"
        private_ip_address            = "10.100.1.4"
        private_ip_address_version    = "IPv4"
        private_ip_address_allocation = "Static"
        primary                       = true
        public_ip_address_id          = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Network/publicIPAddresses/pip-egewg-westeurope-subnet1"
        subnet_id                     = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/dsgsdg/providers/Microsoft.Network/virtualNetworks/egewg/subnets/subnet1"
      }
    ]
  }
}
