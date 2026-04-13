variable "availability_zone" {
  type        = string
  description = "Availability zone where the EBS volume will exist"
}

variable "size" {
  type        = number
  description = "Size of the EBS volume in GiB"
}

variable "type" {
  type        = string
  description = "Type of EBS volume"
}

variable "iops" {
  type        = number
  description = "Amount of IOPS to provision for the disk"
}

variable "encrypted" {
  type        = bool
  description = "Whether the disk will be encrypted"
}

variable "multi_attach_enabled" {
  type        = bool
  description = "Whether to enable EBS Multi-Attach"
}

variable "snapshot_id" {
  type        = string
  description = "Snapshot ID to base the EBS volume off of"
}