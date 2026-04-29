resource "azurerm_virtual_machine" "this" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  vm_size               = var.vm_size
  network_interface_ids = var.network_interface_ids
  zones                 = var.zones
  tags                  = var.tags

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name          = var.os_disk_name
    create_option = "FromImage"
    caching       = var.os_disk_caching
    os_type       = var.os_type
  }

  storage_data_disk {
    name                      = var.data_disk_name
    lun                       = 0
    create_option             = "Attach"
    caching                   = "None"
    disk_size_gb              = var.data_disk_size_gb
    managed_disk_id           = var.data_disk_managed_disk_id
    managed_disk_type         = var.data_disk_managed_disk_type
    write_accelerator_enabled = false
  }

  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = var.disable_password_authentication

    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = var.ssh_public_key_data
    }
  }
}