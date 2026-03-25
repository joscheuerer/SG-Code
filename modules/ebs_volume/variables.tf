variable "availability_zone" {
  description = "Availability zone for the EBS volume"
  type        = string
}

variable "iops" {
  description = "IOPS for the volume"
  type        = number
}

variable "size" {
  description = "Size of the volume in GB"
  type        = number
}

variable "throughput" {
  description = "Throughput in MB/s"
  type        = number
}

variable "volume_type" {
  description = "Type of EBS volume"
  type        = string
}