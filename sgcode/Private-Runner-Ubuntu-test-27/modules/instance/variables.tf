# Variables for the EC2 instance module

variable "ami" {
  description = "AMI ID for the instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID in which to launch the instance."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs."
  type        = list(string)
}

variable "source_dest_check" {
  description = "Whether to enable source/destination checking."
  type        = bool
  default     = true
}

variable "tenancy" {
  description = "Tenancy of the instance (default, dedicated, host)."
  type        = string
  default     = "default"
}

variable "ebs_optimized" {
  description = "Whether the instance is EBS-optimized."
  type        = bool
  default     = false
}

variable "metadata_options" {
  description = "Metadata service options for the instance."
  type = object({
    http_endpoint               = optional(string, "enabled")
    http_tokens                 = optional(string, "optional")
    http_put_response_hop_limit = optional(number, 1)
    instance_metadata_tags      = optional(string, "disabled")
  })
  default = {}
}

variable "root_block_device" {
  description = "Root block device configuration."
  type = object({
    volume_type           = optional(string, "gp2")
    volume_size           = optional(number, 8)
    delete_on_termination = optional(bool, true)
    encrypted             = optional(bool, false)
  })
  default = {}
}

variable "tags" {
  description = "Tags to apply to the instance."
  type        = map(string)
  default     = {}
}
