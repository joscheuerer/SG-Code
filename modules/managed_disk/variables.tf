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
  default     = {}
}