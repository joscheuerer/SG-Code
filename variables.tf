variable "availability_zone" {
  type        = string
  description = "Availability zone for resources"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "snapshot_id" {
  type        = string
  description = "Snapshot ID to create volume from"
}