variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "Availability zone for the instance"
  type        = string
  default     = null
}

variable "disable_api_stop" {
  description = "Whether to disable API stop"
  type        = bool
  default     = false
}

variable "disable_api_termination" {
  description = "Whether to disable API termination"
  type        = bool
  default     = false
}

variable "ebs_optimized" {
  description = "Whether the instance is EBS optimized"
  type        = bool
  default     = false
}

variable "hibernation" {
  description = "Whether to enable hibernation"
  type        = bool
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance"
  type        = string
  default     = "stop"
}

variable "monitoring" {
  description = "Whether detailed monitoring is enabled"
  type        = bool
  default     = false
}

variable "source_dest_check" {
  description = "Whether to enable source/destination checking"
  type        = bool
  default     = true
}

variable "tenancy" {
  description = "Tenancy of the instance"
  type        = string
  default     = "default"
}

variable "tags" {
  description = "Tags to apply to the instance"
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "Tags to apply to volumes"
  type        = map(string)
  default     = {}
}

variable "root_block_device" {
  description = "Root block device configuration"
  type = list(object({
    delete_on_termination = optional(bool, true)
    encrypted             = optional(bool, false)
    iops                  = optional(number, null)
    throughput            = optional(number, null)
    volume_size           = optional(number, null)
    volume_type           = optional(string, null)
    tags                  = optional(map(string), {})
  }))
  default = []
}

variable "credit_specification" {
  description = "Credit specification for the instance"
  type = list(object({
    cpu_credits = string
  }))
  default = []
}

variable "metadata_options" {
  description = "Metadata options for the instance"
  type = list(object({
    http_endpoint               = optional(string, "enabled")
    http_protocol_ipv6          = optional(string, "disabled")
    http_put_response_hop_limit = optional(number, 1)
    http_tokens                 = optional(string, "optional")
    instance_metadata_tags      = optional(string, "disabled")
  }))
  default = []
}

variable "private_dns_name_options" {
  description = "Private DNS name options"
  type = list(object({
    enable_resource_name_dns_a_record    = optional(bool, false)
    enable_resource_name_dns_aaaa_record = optional(bool, false)
    hostname_type                        = optional(string, "ip-name")
  }))
  default = []
}

variable "maintenance_options" {
  description = "Maintenance options for the instance"
  type = list(object({
    auto_recovery = optional(string, "default")
  }))
  default = []
}
