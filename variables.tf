variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "vm_admin_passwords" {
  description = "Map of VM key -> admin password (sensitive). Values live in secrets.auto.tfvars."
  type        = map(string)
  sensitive   = true
  default     = {}
}

variable "windows_virtual_machines" {
  description = "Map of Windows virtual machines to create"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    size                = string
    admin_username      = string

    network_interface_ids        = list(string)
    os_disk_name                 = string
    os_disk_caching              = string
    os_disk_storage_account_type = optional(string, "StandardSSD_LRS")
    os_disk_create_option        = string
    license_type                 = optional(string, null)
    ultra_ssd_enabled            = optional(bool, false)
    hibernation_enabled          = optional(bool, false)

    image_publisher = string
    image_offer     = string
    image_sku       = string
    image_version   = string

    identity_type = string

    boot_diagnostics_enabled     = optional(bool, false)
    boot_diagnostics_storage_uri = optional(string, null)

    patch_mode      = optional(string, "AutomaticByOS")
    assessment_mode = optional(string, "ImageDefault")

    tags = optional(map(string), {})

    extensions = optional(map(object({
      name                       = string
      publisher                  = string
      type                       = string
      type_handler_version       = string
      auto_upgrade_minor_version = optional(bool, true)
      settings                   = optional(string, null)
    })), {})
  }))
}
