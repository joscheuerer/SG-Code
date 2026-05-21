region              = "eastus2"
resource_group_name = "test"
location            = "eastus2"

public_ip_name              = "private-runner-sg-azure2-ip"
public_ip_allocation_method = "Static"
public_ip_sku               = "Standard"
public_ip_zones             = ["1"]

nsg_name = "private-runner-sg-azure2-nsg"
nsg_security_rules = [
  {
    name                       = "SSH"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = 300
    direction                  = "Inbound"
  },
  {
    name                       = "DenyAnyCustomAnyInbound"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Deny"
    priority                   = 310
    direction                  = "Inbound"
  }
]

nic_name                          = "private-runner-sg-azure2113_z1"
nic_accelerated_networking_enabled = false
nic_ip_forwarding_enabled         = false
nic_ip_configuration_name         = "ipconfig1"
nic_subnet_id                     = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/private-runner-sg-azure2-vnet/subnets/default"
nic_private_ip_address_allocation = "Dynamic"
nic_private_ip_address_version    = "IPv4"
nic_ip_configuration_primary      = true

managed_disk_name                 = "private-runner-sg-azure2_OsDisk_1_17de18156ae54efd9060319f1d9c535e"
managed_disk_storage_account_type = "Standard_LRS"
managed_disk_create_option        = "FromImage"
managed_disk_size_gb              = 30
managed_disk_os_type              = "Linux"
managed_disk_hyper_v_generation   = "V2"
managed_disk_trusted_launch_enabled = true
managed_disk_zone                 = "1"
managed_disk_image_reference_id   = "/Subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/Providers/Microsoft.Compute/Locations/eastus2/Publishers/canonical/ArtifactTypes/VMImage/Offers/0001-com-ubuntu-server-focal/Skus/20_04-lts-gen2/Versions/20.04.202307140"

vm_name                            = "private-runner-sg-azure2"
vm_size                            = "Standard_B2s"
vm_zones                           = ["1"]
vm_tags                            = { App = "Mars" }
vm_image_publisher                 = "canonical"
vm_image_offer                     = "0001-com-ubuntu-server-focal"
vm_image_sku                       = "20_04-lts-gen2"
vm_image_version                   = "latest"
vm_os_disk_name                    = "private-runner-sg-azure2_OsDisk_1_17de18156ae54efd9060319f1d9c535e"
vm_os_disk_caching                 = "ReadWrite"
vm_os_disk_create_option           = "FromImage"
vm_os_disk_managed_disk_type       = "Standard_LRS"
vm_os_type                         = "Linux"
vm_computer_name                   = "private-runner-sg-azure2"
vm_admin_username                  = "azueruser"
vm_disable_password_authentication = false
vm_boot_diagnostics_enabled        = true
vm_boot_diagnostics_storage_uri    = ""