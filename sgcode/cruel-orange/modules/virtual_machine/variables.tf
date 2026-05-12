variable "name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region where the VM exists"
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
  description = "Availability zone for the VM"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the VM"
}

variable "os_disk_name" {
  type        = string
  description = "Name of the OS disk"
}

variable "os_disk_create_option" {
  type        = string
  description = "Create option for the OS disk"
}

variable "os_disk_caching" {
  type        = string
  description = "Caching setting for the OS disk"
}

variable "os_type" {
  type        = string
  description = "OS type for the OS disk"
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

variable "computer_name" {
  type        = string
  description = "Computer name of the VM"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "disable_password_authentication" {
  type        = bool
  sensitive   = true
  description = "Whether password authentication is disabled"
}

variable "boot_diagnostics_enabled" {
  type        = bool
  description = "Whether boot diagnostics is enabled"
}

variable "boot_diagnostics_storage_uri" {
  type        = string
  description = "Storage URI for boot diagnostics"
}