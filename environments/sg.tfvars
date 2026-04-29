region = "germanywestcentral"

nsg_name                = "akshat-12-Apr-nsg"
nsg_resource_group_name = "adis"
nsg_tags = {
  creator = "stackgurdian"
}

nic_name                           = "akshat-12-apr966_z1"
nic_resource_group_name            = "adis"
nic_accelerated_networking_enabled = false
nic_ip_forwarding_enabled          = false
nic_subnet_id                      = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/adis-eu/providers/Microsoft.Network/virtualNetworks/sg-runner-vnet/subnets/sg-runner-subnet"
nic_tags = {
  creator = "stackgurdian"
}

managed_disks = {
  akshat_12_apr_datadisk_0 = {
    name                 = "akshat-12-Apr_DataDisk_0"
    resource_group_name  = "adis"
    location             = "germanywestcentral"
    storage_account_type = "Premium_LRS"
    create_option        = "Upload"
    disk_size_gb         = 4
    os_type              = ""
    tags = {
      creator = "stackgurdian"
    }
  }
  akshat_12_apr_osdisk_1_6457833762cd4ee48bf9e0dbee5f3cb8 = {
    name                 = "akshat-12-Apr_OsDisk_1_6457833762cd4ee48bf9e0dbee5f3cb8"
    resource_group_name  = "adis"
    location             = "germanywestcentral"
    storage_account_type = "StandardSSD_LRS"
    create_option        = "Upload"
    disk_size_gb         = 30
    os_type              = "Linux"
    tags = {
      creator = "stackgurdian"
    }
  }
}

vm_name                = "akshat-12-Apr"
vm_resource_group_name = "adis"
vm_size                = "Standard_B2ms"
vm_zones               = ["1"]
vm_image_publisher     = "canonical"
vm_image_offer         = "ubuntu-24_04-lts"
vm_image_sku           = "server"
vm_image_version       = "latest"
vm_os_disk_name        = "akshat-12-Apr_OsDisk_1_6457833762cd4ee48bf9e0dbee5f3cb8"
vm_os_disk_caching     = "ReadWrite"
vm_os_type             = "Linux"
vm_data_disk_name      = "akshat-12-Apr_DataDisk_0"
vm_data_disk_size_gb   = 4
vm_data_disk_managed_disk_type = "Premium_LRS"
vm_computer_name       = "akshat-12-Apr"
vm_admin_username      = "azureuser"
vm_disable_password_authentication = true
vm_ssh_public_key_data = "generated-by-azure"
vm_tags = {
  creator = "stackgurdian"
}