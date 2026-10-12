variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "disable_password_authentication" {
  type    = bool
  default = false
}

variable "network_interface_ids" {
  type = list(string)
}

variable "zone" {
  type    = string
  default = null
}

variable "os_disk_name" {
  type    = string
  default = null
}

variable "os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type    = string
  default = "Premium_LRS"
}

variable "source_image_publisher" {
  type = string
}

variable "source_image_offer" {
  type = string
}

variable "source_image_sku" {
  type = string
}

variable "source_image_version" {
  type    = string
  default = "latest"
}

variable "identity_type" {
  type    = string
  default = null
}

variable "vtpm_enabled" {
  type    = bool
  default = null
}

variable "secure_boot_enabled" {
  type    = bool
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
