variable "name" {
  description = "Name of the Windows virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "size" {
  description = "VM size"
  type        = string
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "admin_password" {
  description = "Admin password"
  type        = string
  sensitive   = true
}

variable "network_interface_ids" {
  description = "List of network interface IDs"
  type        = list(string)
}

variable "os_disk_name" {
  description = "OS disk name"
  type        = string
}

variable "os_disk_caching" {
  description = "OS disk caching"
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "OS disk storage account type"
  type        = string
  default     = "StandardSSD_LRS"
}

variable "os_disk_create_option" {
  description = "OS disk create option"
  type        = string
  default     = "FromImage"
}

variable "license_type" {
  description = "License type for the VM"
  type        = string
  default     = null
}

variable "ultra_ssd_enabled" {
  description = "Whether ultra SSD is enabled"
  type        = bool
  default     = false
}

variable "hibernation_enabled" {
  description = "Whether hibernation is enabled"
  type        = bool
  default     = false
}

variable "image_publisher" {
  description = "Image publisher"
  type        = string
}

variable "image_offer" {
  description = "Image offer"
  type        = string
}

variable "image_sku" {
  description = "Image SKU"
  type        = string
}

variable "image_version" {
  description = "Image version"
  type        = string
  default     = "latest"
}

variable "identity_type" {
  description = "Identity type"
  type        = string
  default     = "SystemAssigned"
}

variable "boot_diagnostics_enabled" {
  description = "Enable boot diagnostics"
  type        = bool
  default     = false
}

variable "boot_diagnostics_storage_uri" {
  description = "Boot diagnostics storage URI (null = managed storage)"
  type        = string
  default     = null
}

variable "patch_mode" {
  description = "Patch mode"
  type        = string
  default     = "AutomaticByOS"
}

variable "assessment_mode" {
  description = "Assessment mode"
  type        = string
  default     = "ImageDefault"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "extensions" {
  description = "Map of VM extensions"
  type = map(object({
    name                       = string
    publisher                  = string
    type                       = string
    type_handler_version       = string
    auto_upgrade_minor_version = optional(bool, true)
    settings                   = optional(string, null)
  }))
  default = {}
}
