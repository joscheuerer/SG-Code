variable "availability_zone" {
  type        = string
  description = "Availability zone where the EBS volume will exist"
}

variable "size" {
  type        = number
  description = "Size of the drive in GiBs"
}

variable "type" {
  type        = string
  description = "Type of EBS volume"
}

variable "iops" {
  type        = number
  description = "Amount of IOPS to provision for the disk"
}

variable "throughput" {
  type        = number
  description = "Throughput that the volume supports in MiB/s"
}

variable "encrypted" {
  type        = bool
  description = "Whether the disk will be encrypted"
}

variable "multi_attach_enabled" {
  type        = bool
  description = "Whether to enable Amazon EBS Multi-Attach"
}

variable "snapshot_id" {
  type        = string
  description = "Snapshot to base the EBS volume off of"
}