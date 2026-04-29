variable "name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for the VM"
}

variable "location" {
  type        = string
  description = "Azure region for the VM"
}

variable "vm_size" {
  type        = string
  description = "Size of the virtual machine"
}

variable "network_interface_ids" {
  type        = list(string)
  description = "List of network interface IDs to attach to the VM"
}

variable "zones" {
  type        = list(string)
  description = "Availability zones for the VM"
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

variable "os_type" {
  type        = string
  description = "Operating system type"
}

variable "data_disk_name" {
  type        = string
  description = "Name of the data disk"
}

variable "data_disk_size_gb" {
  type        = number
  description = "Size of the data disk in GB"
}

variable "data_disk_managed_disk_id" {
  type        = string
  description = "ID of the managed data disk to attach"
}

variable "data_disk_managed_disk_type" {
  type        = string
  description = "Storage account type for the data disk"
}

variable "computer_name" {
  type        = string
  description = "Computer name for the VM OS profile"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "disable_password_authentication" {
  type        = bool
  description = "Whether to disable password authentication on the Linux VM"
  sensitive   = true
}

variable "ssh_public_key_data" {
  type        = string
  description = "SSH public key data for the admin user"
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the VM"
}