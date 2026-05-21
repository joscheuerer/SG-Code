variable "name" {
  type        = string
  description = "Name of the managed disk"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region where the managed disk should exist"
}

variable "storage_account_type" {
  type        = string
  description = "Storage account type for the managed disk (e.g. Standard_LRS)"
}

variable "create_option" {
  type        = string
  description = "Method to use when creating the managed disk"
}

variable "disk_size_gb" {
  type        = number
  description = "Size of the managed disk in gigabytes"
}

variable "os_type" {
  type        = string
  description = "Operating system type on the managed disk (Linux or Windows)"
}

variable "hyper_v_generation" {
  type        = string
  description = "The HyperV Generation of the disk (V1 or V2)"
}

variable "trusted_launch_enabled" {
  type        = bool
  description = "Whether trusted launch is enabled for the managed disk"
}

variable "zone" {
  type        = string
  description = "Availability zone where the managed disk should be created"
}

variable "image_reference_id" {
  type        = string
  description = "ID of an existing platform/marketplace disk image to copy when create_option is FromImage"
}