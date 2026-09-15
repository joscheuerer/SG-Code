variable "instances" {
  description = "Map of EC2 instance configurations"
  type = map(object({
    ami                                  = string
    instance_type                        = string
    subnet_id                            = string
    vpc_security_group_ids               = list(string)
    associate_public_ip_address          = optional(bool, false)
    availability_zone                    = optional(string, null)
    disable_api_stop                     = optional(bool, false)
    disable_api_termination              = optional(bool, false)
    ebs_optimized                        = optional(bool, false)
    hibernation                          = optional(bool, false)
    instance_initiated_shutdown_behavior = optional(string, "stop")
    monitoring                           = optional(bool, false)
    source_dest_check                    = optional(bool, true)
    tenancy                              = optional(string, "default")
    tags                                 = optional(map(string), {})
    volume_tags                          = optional(map(string), {})
    root_block_device = optional(list(object({
      delete_on_termination = optional(bool, true)
      encrypted             = optional(bool, false)
      iops                  = optional(number, null)
      throughput            = optional(number, null)
      volume_size           = optional(number, null)
      volume_type           = optional(string, null)
      tags                  = optional(map(string), {})
    })), [])
    credit_specification = optional(list(object({
      cpu_credits = string
    })), [])
    metadata_options = optional(list(object({
      http_endpoint               = optional(string, "enabled")
      http_protocol_ipv6          = optional(string, "disabled")
      http_put_response_hop_limit = optional(number, 1)
      http_tokens                 = optional(string, "optional")
      instance_metadata_tags      = optional(string, "disabled")
    })), [])
    private_dns_name_options = optional(list(object({
      enable_resource_name_dns_a_record    = optional(bool, false)
      enable_resource_name_dns_aaaa_record = optional(bool, false)
      hostname_type                        = optional(string, "ip-name")
    })), [])
    maintenance_options = optional(list(object({
      auto_recovery = optional(string, "default")
    })), [])
  }))
  default = {}
}
