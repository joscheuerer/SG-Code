# Variables for the EBS volume module

variable "availability_zone" {
  description = "AZ in which to create the volume."
  type        = string
}

variable "size" {
  description = "Size of the volume in GiB."
  type        = number
}

variable "type" {
  description = "Volume type (gp2, gp3, io1, io2, sc1, st1, standard)."
  type        = string
}

variable "iops" {
  description = "IOPS for the volume (io1/io2/gp3)."
  type        = number
  default     = null
}

variable "throughput" {
  description = "Throughput in MiB/s (gp3 only)."
  type        = number
  default     = null
}

variable "encrypted" {
  description = "Whether the volume is encrypted."
  type        = bool
  default     = false
}

variable "multi_attach_enabled" {
  description = "Whether to enable multi-attach (io1/io2 only)."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the volume."
  type        = map(string)
  default     = {}
}
