variable "availability_zone" {
  description = "Availability zone where the EBS volume will exist"
  type        = string
}

variable "size" {
  description = "Size of the drive in GiBs"
  type        = number
}

variable "type" {
  description = "Type of EBS volume"
  type        = string
}

variable "iops" {
  description = "Amount of IOPS to provision for the disk"
  type        = number
}

variable "throughput" {
  description = "Throughput that the volume supports in MiB/s"
  type        = number
}

variable "encrypted" {
  description = "Whether the disk will be encrypted"
  type        = bool
}

variable "multi_attach_enabled" {
  description = "Whether to enable Amazon EBS Multi-Attach"
  type        = bool
}

variable "snapshot_id" {
  description = "Snapshot ID to base the EBS volume off of"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the EBS volume"
  type        = map(string)
}