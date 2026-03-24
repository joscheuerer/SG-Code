variable "availability_zone" {
  type        = string
  description = "Availability zone for the volume"
}

variable "size" {
  type        = number
  description = "Size of the volume in GiB"
}

variable "volume_type" {
  type        = string
  description = "Type of volume"
}

variable "iops" {
  type        = number
  description = "IOPS for the volume"
}

variable "throughput" {
  type        = number
  description = "Throughput for the volume"
}

variable "encrypted" {
  type        = bool
  description = "Whether the volume is encrypted"
}

variable "snapshot_id" {
  type        = string
  description = "Snapshot ID to create volume from"
}