variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "key_name" {
  type    = string
  default = null
}

variable "associate_public_ip_address" {
  type    = bool
  default = null
}

variable "source_dest_check" {
  type    = bool
  default = true
}

variable "monitoring" {
  type    = bool
  default = false
}

variable "disable_api_stop" {
  type    = bool
  default = false
}

variable "disable_api_termination" {
  type    = bool
  default = false
}

variable "ebs_optimized" {
  type    = bool
  default = false
}

variable "hibernation" {
  type    = bool
  default = false
}

variable "instance_initiated_shutdown_behavior" {
  type    = string
  default = "stop"
}

variable "tenancy" {
  type    = string
  default = "default"
}

variable "user_data_replace_on_change" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "volume_tags" {
  type    = map(string)
  default = {}
}

variable "root_block_device" {
  type = object({
    delete_on_termination = optional(bool, true)
    encrypted             = optional(bool, false)
    volume_size           = optional(number, null)
    volume_type           = optional(string, null)
    iops                  = optional(number, null)
    throughput            = optional(number, null)
    kms_key_id            = optional(string, null)
    tags                  = optional(map(string), {})
  })
  default = null
}

variable "metadata_options" {
  type = object({
    http_endpoint               = optional(string, "enabled")
    http_protocol_ipv6          = optional(string, "disabled")
    http_put_response_hop_limit = optional(number, 1)
    http_tokens                 = optional(string, "optional")
    instance_metadata_tags      = optional(string, "disabled")
  })
  default = null
}

variable "credit_specification" {
  type = object({
    cpu_credits = optional(string, "standard")
  })
  default = null
}

variable "cpu_options" {
  type = object({
    core_count       = optional(number, null)
    threads_per_core = optional(number, null)
  })
  default = null
}

variable "maintenance_options" {
  type = object({
    auto_recovery = optional(string, "default")
  })
  default = null
}

variable "private_dns_name_options" {
  type = object({
    enable_resource_name_dns_a_record    = optional(bool, false)
    enable_resource_name_dns_aaaa_record = optional(bool, false)
    hostname_type                        = optional(string, "ip-name")
  })
  default = null
}
