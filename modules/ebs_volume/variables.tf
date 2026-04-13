variable "availability_zone" {
  type        = string
  description = "The availability zone in which to create the volume"
}

variable "size" {
  type        = number
  description = "The size of the volume in GiB"
}

variable "type" {
  type        = string
  description = "The type of the EBS volume"
}

variable "iops" {
  type        = number
  description = "The IOPS for the volume"
}

variable "encrypted" {
  type        = bool
  description = "Whether the volume is encrypted"
}

variable "multi_attach_enabled" {
  type        = bool
  description = "Whether multi-attach is enabled for the volume"
}

variable "snapshot_id" {
  type        = string
  description = "The snapshot ID from which the volume was created (external reference)"
}