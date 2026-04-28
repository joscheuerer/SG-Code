variable "instances" {
  description = "Map of EC2 instances to create"
  type = map(object({
    ami_id                      = string
    instance_type               = string
    availability_zone           = string
    key_name                    = string
    iam_instance_profile_arn    = optional(string)
    subnet_id                   = string
    security_group_ids          = list(string)
    associate_public_ip_address = bool
    source_dest_check           = bool
    ebs_optimized               = bool
    monitoring                  = bool
    tenancy                     = string
    hibernation                 = bool
    cpu_core_count              = number
    cpu_threads_per_core        = number
    metadata_options = object({
      http_endpoint               = string
      http_tokens                 = string
      http_put_response_hop_limit = number
      http_protocol_ipv6          = string
      instance_metadata_tags      = string
    })
    capacity_reservation_specification = object({
      capacity_reservation_preference = string
    })
    enclave_options = object({
      enabled = bool
    })
    root_block_device = object({
      volume_type           = string
      delete_on_termination = bool
    })
    tags = map(string)
  }))
}

variable "additional_ebs_volumes" {
  description = "Additional EBS volumes to attach to instances"
  type = map(object({
    instance_key      = string
    device_name       = string
    availability_zone = string
    size              = number
    type              = string
    encrypted         = bool
    force_detach      = bool
    tags              = map(string)
  }))
  default = {}
}