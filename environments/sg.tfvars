managed_disks = {
  pr_of_the_galaxy_osdisk = {
    name                   = "pr-of-the-galaxy_OsDisk_1_80e28f24ebe24f8ea996a7737e43faeb"
    resource_group_name    = "jo-test"
    location               = "germanywestcentral"
    storage_account_type   = "Premium_LRS"
    disk_size_gb           = 30
    create_option          = "FromImage"
    hyper_v_generation     = "V2"
    trusted_launch_enabled = true
    zone                   = "1"
    os_type                = "Linux"
  }
}

network_interfaces = {
  pr_of_the_galaxy24_z1 = {
    name                = "pr-of-the-galaxy24_z1"
    resource_group_name = "jo-test"
    location            = "germanywestcentral"
    ip_configurations = [
      {
        name                          = "ipconfig1"
        subnet_id                     = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Network/virtualNetworks/jovnet-do-not-delete/subnets/subnet1"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Network/publicIPAddresses/pr-of-the-galaxy-ip"
        primary                       = true
      }
    ]
    accelerated_networking_enabled = false
    ip_forwarding_enabled          = false
    network_security_group_id      = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Network/networkSecurityGroups/pr-of-the-galaxy-nsg"
  }
}

linux_virtual_machines = {
  pr_of_the_galaxy = {
    name                            = "pr-of-the-galaxy"
    resource_group_name             = "jo-test"
    location                        = "germanywestcentral"
    size                            = "Standard_B2s"
    admin_username                  = "azureuser"
    disable_password_authentication = false
    network_interface_ids           = ["/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Network/networkInterfaces/pr-of-the-galaxy24_z1"]
    zone                            = "1"
    os_disk_name                    = "pr-of-the-galaxy_OsDisk_1_80e28f24ebe24f8ea996a7737e43faeb"
    os_disk_caching                 = "ReadWrite"
    os_disk_storage_account_type    = "Premium_LRS"
    source_image_publisher          = "canonical"
    source_image_offer              = "ubuntu-24_04-lts"
    source_image_sku                = "server"
    source_image_version            = "latest"
    identity_type                   = "SystemAssigned"
    vtpm_enabled                    = true
    secure_boot_enabled             = true
  }
}

key_vaults = {
  testmenow = {
    name                            = "testmenow"
    resource_group_name             = "jo-test"
    location                        = "eastus"
    tenant_id                       = "e486c990-3cab-4813-a86a-77b4c6b8f3d6"
    sku_name                        = "standard"
    enabled_for_deployment          = true
    enabled_for_disk_encryption     = false
    enabled_for_template_deployment = false
    purge_protection_enabled        = false
    soft_delete_retention_days      = 90
    enable_rbac_authorization       = true
  }
}

logic_app_workflows = {
  read_audit_logs = {
    name                = "ReadAuditLogs"
    resource_group_name = "jo-test"
    location            = "westeurope"
    workflow_schema     = "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#"
    workflow_version    = "1.0.0.0"
    enabled             = false
  }
}
