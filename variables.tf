variable "region" {
  type        = string
  description = "Azure region for the provider"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region where resources should exist"
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public IP resource"
}

variable "public_ip_allocation_method" {
  type        = string
  description = "Allocation method for the public IP address (Static or Dynamic)"
}

variable "public_ip_sku" {
  type        = string
  description = "SKU of the public IP (Basic, Standard, or StandardV2)"
}

variable "public_ip_zones" {
  type        = list(string)
  description = "Availability zones for the public IP"
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
  description = "List of security rules for the NSG"
}

variable "nic_name" {
  type        = string
  description = "Name of the network interface"
}

variable "nic_accelerated_networking_enabled" {
  type        = bool
  description = "Should accelerated networking be enabled on the NIC"
}

variable "nic_ip_forwarding_enabled" {
  type        = bool
  description = "Should IP forwarding be enabled on the NIC"
}

variable "nic_ip_configuration_name" {
  type        = string
  description = "Name of the NIC IP configuration"
}

variable "nic_subnet_id" {
  type        = string
  description = "ID of the subnet for the NIC IP configuration"
}

variable "nic_private_ip_address_allocation" {
  type        = string
  description = "Private IP address allocation method for the NIC (Dynamic or Static)"
}

variable "nic_private_ip_address_version" {
  type        = string
  description = "IP version for the NIC private IP address (IPv4 or IPv6)"
}

variable "nic_ip_configuration_primary" {
  type        = bool
  description = "Is this the primary IP configuration on the NIC"
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
  description = "Method to use when creating the managed disk"
}

variable "managed_disk_size_gb" {
  type        = number
  description = "Size of the managed disk in gigabytes"
}

variable "managed_disk_os_type" {
  type        = string
  description = "Operating system type on the managed disk (Linux or Windows)"
}

variable "managed_disk_hyper_v_generation" {
  type        = string
  description = "The HyperV Generation of the disk (V1 or V2)"
}

variable "managed_disk_trusted_launch_enabled" {
  type        = bool
  description = "Whether trusted launch is enabled for the managed disk"
}

variable "managed_disk_zone" {
  type        = string
  description = "Availability zone where the managed disk should be created"
}

variable "managed_disk_image_reference_id" {
  type        = string
  description = "ID of an existing platform/marketplace disk image to copy when create_option is FromImage"
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
  description = "Availability zones for the virtual machine"
}

variable "vm_tags" {
  type        = map(string)
  description = "Tags to assign to the virtual machine"
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

variable "vm_os_disk_create_option" {
  type        = string
  description = "Create option for the OS disk"
}

variable "vm_os_disk_managed_disk_type" {
  type        = string
  description = "Managed disk type for the OS disk"
}

variable "vm_os_type" {
  type        = string
  description = "Operating system type (Linux or Windows)"
}

variable "vm_computer_name" {
  type        = string
  description = "Computer name for the virtual machine"
}

variable "vm_admin_username" {
  type        = string
  description = "Admin username for the virtual machine"
}

variable "vm_disable_password_authentication" {
  type        = bool
  description = "Whether to disable password authentication on the Linux VM"
}

variable "vm_boot_diagnostics_enabled" {
  type        = bool
  description = "Whether boot diagnostics is enabled"
}

variable "vm_boot_diagnostics_storage_uri" {
  type        = string
  description = "Storage account blob endpoint for boot diagnostics"
}