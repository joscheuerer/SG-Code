# Root variables forwarded to child modules

variable "instances" {
  description = "Map of EC2 instance configurations keyed by name."
  type = map(object({
    ami                    = string
    instance_type          = string
    key_name               = string
    subnet_id              = string
    vpc_security_group_ids = list(string)
    source_dest_check      = optional(bool, true)
    tenancy                = optional(string, "default")
    ebs_optimized          = optional(bool, false)
    metadata_options = optional(object({
      http_endpoint               = optional(string, "enabled")
      http_tokens                 = optional(string, "optional")
      http_put_response_hop_limit = optional(number, 1)
      instance_metadata_tags      = optional(string, "disabled")
    }), {})
    root_block_device = optional(object({
      volume_type           = optional(string, "gp2")
      volume_size           = optional(number, 8)
      delete_on_termination = optional(bool, true)
      encrypted             = optional(bool, false)
    }), {})
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "ebs_volumes" {
  description = "Map of standalone EBS volume configurations keyed by volume id."
  type = map(object({
    availability_zone    = string
    size                 = number
    type                 = string
    iops                 = optional(number, null)
    throughput           = optional(number, null)
    encrypted            = optional(bool, false)
    multi_attach_enabled = optional(bool, false)
    tags                 = optional(map(string), {})
  }))
  default = {}
}

variable "key_pairs" {
  description = "Map of key pair configurations keyed by key name (public_key excluded; supplied separately)."
  type = map(object({
    key_name = string
    tags     = optional(map(string), {})
  }))
  default = {}
}

# Write-only public key values, keyed by key pair map key.
# Sensitive: stored in secrets.auto.tfvars; ignored after import via lifecycle.
variable "key_pair_public_keys" {
  description = "Map of public key material keyed by key pair map key. Sensitive; write-only."
  type        = map(string)
  sensitive   = true
  default     = {}
}
