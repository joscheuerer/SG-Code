variable "instances" {
  description = "EC2 instances to create"
  type = map(object({
    ami_id                         = string
    instance_type                  = string
    availability_zone              = string
    key_name                       = string
    iam_instance_profile_arn       = optional(string)
    subnet_id                      = string
    security_group_ids             = list(string)
    associate_public_ip_address    = bool
    source_dest_check              = bool
    ebs_optimized                  = bool
    monitoring_enabled             = bool
    tenancy                        = string
    cpu_core_count                 = number
    cpu_threads_per_core           = number
    root_volume_type               = string
    root_volume_size               = number
    root_delete_on_termination     = bool
    metadata_http_endpoint         = string
    metadata_http_tokens           = string
    metadata_hop_limit             = number
    metadata_http_protocol_ipv6    = string
    metadata_instance_tags         = string
    enclave_enabled                = bool
    capacity_reservation_preference = string
    tags                           = map(string)
  }))
}

variable "ebs_volumes" {
  description = "Additional EBS volumes to create"
  type = map(object({
    availability_zone    = string
    size                 = number
    volume_type          = string
    iops                 = optional(number)
    throughput           = optional(number)
    encrypted            = bool
    snapshot_id          = optional(string)
    multi_attach_enabled = bool
  }))
  default = {}
}

variable "volume_attachments" {
  description = "EBS volume attachments to instances"
  type = map(object({
    device_name                    = string
    volume_id                      = string
    instance_id                    = string
    stop_instance_before_detaching = bool
  }))
  default = {}
}