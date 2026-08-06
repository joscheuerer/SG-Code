variable "name" {
  type        = string
  description = "Name of the managed disk"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region where the managed disk exists"
}

variable "storage_account_type" {
  type        = string
  description = "Storage account type for the managed disk"
}

variable "create_option" {
  type        = string
  description = "Create option for the managed disk"
}

variable "disk_size_gb" {
  type        = number
  description = "Size of the managed disk in GB"
}

variable "os_type" {
  type        = string
  description = "OS type for the managed disk"
}

variable "hyper_v_generation" {
  type        = string
  description = "HyperV generation of the managed disk"
  default     = null
}

variable "trusted_launch_enabled" {
  type        = bool
  description = "Whether trusted launch is enabled for the managed disk"
  default     = null
}

variable "zone" {
  type        = string
  description = "Availability zone for the managed disk"
  default     = null
}