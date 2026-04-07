variable "availability_zone" {
  type        = string
  description = "Availability zone for the EBS volume"
}

variable "size" {
  type        = number
  description = "Size of the volume in GiB"
}

variable "volume_type" {
  type        = string
  description = "Type of EBS volume"
}

variable "encrypted" {
  type        = bool
  description = "Whether the volume is encrypted"
}

variable "iops" {
  type        = number
  description = "IOPS for the volume"
}

variable "snapshot_id" {
  type        = string
  description = "Snapshot ID to create volume from"
}