variable "volumes" {
  description = "EBS volumes to create"
  type = map(object({
    availability_zone     = string
    encrypted             = bool
    iops                  = number
    multi_attach_enabled  = bool
    size                  = number
    snapshot_id           = string
    throughput            = number
    volume_type           = string
    tags                  = optional(map(string), {})
  }))
  default = {}
}