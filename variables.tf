variable "managed_disks" {
  type = map(object({
    name                   = string
    resource_group_name    = string
    location               = string
    storage_account_type   = string
    disk_size_gb           = number
    create_option          = optional(string, "Empty")
    hyper_v_generation     = optional(string)
    trusted_launch_enabled = optional(bool)
    zone                   = optional(string)
    os_type                = optional(string)
    tags                   = optional(map(string), {})
  }))
  default = {}
}

variable "linux_virtual_machines" {
  type = map(object({
    name                            = string
    resource_group_name             = string
    location                        = string
    size                            = string
    admin_username                  = string
    disable_password_authentication = optional(bool, false)
    network_interface_ids           = list(string)
    zone                            = optional(string)
    os_disk_name                    = optional(string)
    os_disk_caching                 = optional(string, "ReadWrite")
    os_disk_storage_account_type    = optional(string, "Premium_LRS")
    source_image_publisher          = string
    source_image_offer              = string
    source_image_sku                = string
    source_image_version            = optional(string, "latest")
    identity_type                   = optional(string)
    vtpm_enabled                    = optional(bool)
    secure_boot_enabled             = optional(bool)
    tags                            = optional(map(string), {})
  }))
  default = {}
}

variable "network_interfaces" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    ip_configurations = list(object({
      name                          = string
      subnet_id                     = string
      private_ip_address_allocation = string
      public_ip_address_id          = optional(string)
      primary                       = optional(bool)
    }))
    accelerated_networking_enabled = optional(bool, false)
    ip_forwarding_enabled          = optional(bool, false)
    network_security_group_id      = optional(string)
    tags                           = optional(map(string), {})
  }))
  default = {}
}

variable "key_vaults" {
  type = map(object({
    name                            = string
    resource_group_name             = string
    location                        = string
    tenant_id                       = string
    sku_name                        = string
    enabled_for_deployment          = optional(bool, false)
    enabled_for_disk_encryption     = optional(bool, false)
    enabled_for_template_deployment = optional(bool, false)
    purge_protection_enabled        = optional(bool, false)
    soft_delete_retention_days      = optional(number, 90)
    enable_rbac_authorization       = optional(bool, false)
    tags                            = optional(map(string), {})
  }))
  default = {}
}

variable "logic_app_workflows" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    workflow_schema     = optional(string)
    workflow_version    = optional(string)
    enabled             = optional(bool, true)
    parameters          = optional(map(string), {})
    tags                = optional(map(string), {})
  }))
  default = {}
}

variable "logic_app_workflow_definition" {
  type      = string
  default   = ""
  sensitive = false
}

variable "sg_api_key" {
  type      = string
  sensitive = true
  default   = ""
}
