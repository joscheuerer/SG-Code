variable "name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region where the VM should exist"
}

variable "vm_size" {
  type        = string
  description = "Size of the virtual machine"
}

variable "network_interface_ids" {
  type        = list(string)
  description = "List of network interface IDs to associate with the VM"
}

variable "zones" {
  type        = list(string)
  description = "Availability zones for the virtual machine"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the virtual machine"
}

variable "image_publisher" {
  type        = string
  description = "Publisher of the VM image"
}

variable "image_offer" {
  type        = string
  description = "Offer of the VM image"
}

variable "image_sku" {
  type        = string
  description = "SKU of the VM image"
}

variable "image_version" {
  type        = string
  description = "Version of the VM image"
}

variable "os_disk_name" {
  type        = string
  description = "Name of the OS disk"
}

variable "os_disk_caching" {
  type        = string
  description = "Caching setting for the OS disk"
}

variable "os_disk_create_option" {
  type        = string
  description = "Create option for the OS disk"
}

variable "os_disk_managed_disk_type" {
  type        = string
  description = "Managed disk type for the OS disk"
}

variable "os_type" {
  type        = string
  description = "Operating system type (Linux or Windows)"
}

variable "computer_name" {
  type        = string
  description = "Computer name for the virtual machine"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the virtual machine"
}

variable "disable_password_authentication" {
  type        = bool
  description = "Whether to disable password authentication on the Linux VM"
}

variable "boot_diagnostics_enabled" {
  type        = bool
  description = "Whether boot diagnostics is enabled"
}

variable "boot_diagnostics_storage_uri" {
  type        = string
  description = "Storage account blob endpoint for boot diagnostics"
}