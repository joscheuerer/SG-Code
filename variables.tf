variable "region" {
  type        = string
  description = "Azure region for all resources"
}

variable "nsg_name" {
  type        = string
  description = "Name of the network security group"
}

variable "nsg_resource_group_name" {
  type        = string
  description = "Resource group name for the NSG"
}

variable "nsg_tags" {
  type        = map(string)
  description = "Tags to assign to the NSG"
}

variable "nic_name" {
  type        = string
  description = "Name of the network interface"
}

variable "nic_resource_group_name" {
  type        = string
  description = "Resource group name for the NIC"
}

variable "nic_accelerated_networking_enabled" {
  type        = bool
  description = "Whether accelerated networking is enabled on the NIC"
}

variable "nic_ip_forwarding_enabled" {
  type        = bool
  description = "Whether IP forwarding is enabled on the NIC"
}

variable "nic_subnet_id" {
  type        = string
  description = "The ID of the subnet for the NIC ip configuration"
}

variable "nic_tags" {
  type        = map(string)
  description = "Tags to assign to the NIC"
}

variable "managed_disks" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    location             = string
    storage_account_type = string
    create_option        = string
    disk_size_gb         = number
    os_type              = string
    tags                 = map(string)
  }))
  description = "Map of managed disks to create"
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "vm_resource_group_name" {
  type        = string
  description = "Resource group name for the VM"
}

variable "vm_size" {
  type        = string
  description = "Size of the virtual machine"
}

variable "vm_zones" {
  type        = list(string)
  description = "Availability zones for the VM"
}

variable "vm_image_publisher" {
  type        = string
  description = "Publisher of the VM image"
}

variable "vm_image_offer" {
  type        = string
  description = "Offer of the VM image"
}

variable "vm_image_sku" {
  type        = string
  description = "SKU of the VM image"
}

variable "vm_image_version" {
  type        = string
  description = "Version of the VM image"
}

variable "vm_os_disk_name" {
  type        = string
  description = "Name of the OS disk"
}

variable "vm_os_disk_caching" {
  type        = string
  description = "Caching setting for the OS disk"
}

variable "vm_os_type" {
  type        = string
  description = "Operating system type for the VM"
}

variable "vm_data_disk_name" {
  type        = string
  description = "Name of the data disk"
}

variable "vm_data_disk_size_gb" {
  type        = number
  description = "Size of the data disk in GB"
}

variable "vm_data_disk_managed_disk_type" {
  type        = string
  description = "Storage account type for the data disk"
}

variable "vm_computer_name" {
  type        = string
  description = "Computer name for the VM OS profile"
}

variable "vm_admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "vm_disable_password_authentication" {
  type        = bool
  description = "Whether to disable password authentication on the Linux VM"
  sensitive   = true
}

variable "vm_ssh_public_key_data" {
  type        = string
  description = "SSH public key data for the admin user"
  sensitive   = true
}

variable "vm_tags" {
  type        = map(string)
  description = "Tags to assign to the VM"
}