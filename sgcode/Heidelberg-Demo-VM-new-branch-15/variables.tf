variable "instances" {
  description = "Map of EC2 instances to create"
  type = map(object({
    ami                                  = string
    instance_type                        = string
    availability_zone                    = string
    subnet_id                            = string
    vpc_security_group_ids               = list(string)
    key_name                             = optional(string, null)
    associate_public_ip_address          = optional(bool, null)
    source_dest_check                    = optional(bool, true)
    monitoring                           = optional(bool, false)
    disable_api_stop                     = optional(bool, false)
    disable_api_termination              = optional(bool, false)
    ebs_optimized                        = optional(bool, false)
    hibernation                          = optional(bool, false)
    instance_initiated_shutdown_behavior = optional(string, "stop")
    tenancy                              = optional(string, "default")
    user_data_replace_on_change          = optional(bool, false)
    tags                                 = optional(map(string), {})
    volume_tags                          = optional(map(string), {})
    root_block_device = optional(object({
      delete_on_termination = optional(bool, true)
      encrypted             = optional(bool, false)
      volume_size           = optional(number, null)
      volume_type           = optional(string, null)
      iops                  = optional(number, null)
      throughput            = optional(number, null)
      kms_key_id            = optional(string, null)
      tags                  = optional(map(string), {})
    }), null)
    metadata_options = optional(object({
      http_endpoint               = optional(string, "enabled")
      http_protocol_ipv6          = optional(string, "disabled")
      http_put_response_hop_limit = optional(number, 1)
      http_tokens                 = optional(string, "optional")
      instance_metadata_tags      = optional(string, "disabled")
    }), null)
    credit_specification = optional(object({
      cpu_credits = optional(string, "standard")
    }), null)
    cpu_options = optional(object({
      core_count       = optional(number, null)
      threads_per_core = optional(number, null)
    }), null)
    maintenance_options = optional(object({
      auto_recovery = optional(string, "default")
    }), null)
    private_dns_name_options = optional(object({
      enable_resource_name_dns_a_record    = optional(bool, false)
      enable_resource_name_dns_aaaa_record = optional(bool, false)
      hostname_type                        = optional(string, "ip-name")
    }), null)
  }))
  default = {}
}
