variable "region" {
  type        = string
  description = "Azure region for the provider"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region where resources exist"
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "vm_size" {
  type        = string
  description = "Size of the virtual machine"
}

variable "vm_zones" {
  type        = list(string)
  description = "Availability zones for the VM"
}

variable "vm_tags" {
  type        = map(string)
  description = "Tags to assign to the VM"
}

variable "vm_os_disk_name" {
  type        = string
  description = "Name of the OS disk"
}

variable "vm_os_disk_create_option" {
  type        = string
  description = "Create option for the OS disk"
}

variable "vm_os_disk_caching" {
  type        = string
  description = "Caching setting for the OS disk"
}

variable "vm_os_type" {
  type        = string
  description = "OS type for the OS disk"
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

variable "vm_computer_name" {
  type        = string
  description = "Computer name of the VM"
}

variable "vm_admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "vm_disable_password_authentication" {
  type        = bool
  sensitive   = true
  description = "Whether password authentication is disabled"
  default     = null
}

variable "vm_boot_diagnostics_enabled" {
  type        = bool
  description = "Whether boot diagnostics is enabled"
}

variable "vm_boot_diagnostics_storage_uri" {
  type        = string
  description = "Storage URI for boot diagnostics"
}

variable "managed_disk_name" {
  type        = string
  description = "Name of the managed disk"
}

variable "managed_disk_storage_account_type" {
  type        = string
  description = "Storage account type for the managed disk"
}

variable "managed_disk_create_option" {
  type        = string
  description = "Create option for the managed disk"
}

variable "managed_disk_size_gb" {
  type        = number
  description = "Size of the managed disk in GB"
}

variable "managed_disk_os_type" {
  type        = string
  description = "OS type for the managed disk"
}

variable "managed_disk_hyper_v_generation" {
  type        = string
  description = "HyperV generation of the managed disk"
  default     = null
}

variable "managed_disk_trusted_launch_enabled" {
  type        = bool
  description = "Whether trusted launch is enabled for the managed disk"
  default     = null
}

variable "managed_disk_zone" {
  type        = string
  description = "Availability zone for the managed disk"
  default     = null
}

variable "nic_name" {
  type        = string
  description = "Name of the network interface"
}

variable "nic_accelerated_networking_enabled" {
  type        = bool
  description = "Whether accelerated networking is enabled"
}

variable "nic_ip_forwarding_enabled" {
  type        = bool
  description = "Whether IP forwarding is enabled"
}

variable "nic_ip_config_name" {
  type        = string
  description = "Name of the IP configuration"
}

variable "nic_private_ip_address_allocation" {
  type        = string
  description = "Private IP address allocation method"
}

variable "nic_private_ip_address_version" {
  type        = string
  description = "Private IP address version"
}

variable "nic_subnet_id" {
  type        = string
  description = "ID of the subnet"
}

variable "nic_ip_config_primary" {
  type        = bool
  description = "Whether this is the primary IP configuration"
}

variable "nsg_name" {
  type        = string
  description = "Name of the network security group"
}

variable "nsg_security_rules" {
  type = list(object({
    name                       = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    access                     = string
    priority                   = number
    direction                  = string
  }))
  description = "List of custom security rules for the NSG"
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public IP"
}

variable "public_ip_allocation_method" {
  type        = string
  description = "Allocation method for the public IP"
}

variable "public_ip_sku" {
  type        = string
  description = "SKU of the public IP"
}

variable "public_ip_version" {
  type        = string
  description = "IP version for the public IP"
}

variable "public_ip_zones" {
  type        = list(string)
  description = "Availability zones for the public IP"
}