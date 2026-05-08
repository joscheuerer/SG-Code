variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
}

variable "instance_profile_path" {
  description = "Path to the IAM instance profile"
  type        = string
}

variable "instance_profile_role" {
  description = "Name of the IAM role to associate with the instance profile"
  type        = string
}

variable "key_pair_key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "key_pair_public_key" {
  description = "Public key material for the EC2 key pair"
  type        = string
  sensitive   = true
}

variable "instances" {
  description = "Map of EC2 instance configurations"
  type = map(object({
    ami                         = string
    associate_public_ip_address = bool
    availability_zone           = string
    ebs_optimized               = bool
    iam_instance_profile        = string
    instance_type               = string
    key_name                    = string
    monitoring                  = bool
    source_dest_check           = bool
    subnet_id                   = string
    tags                        = map(string)
    tenancy                     = string
    volume_tags                 = map(string)
    vpc_security_group_ids      = list(string)

    capacity_reservation_preference = string
    enclave_options_enabled         = bool

    metadata_http_endpoint               = string
    metadata_http_protocol_ipv6          = string
    metadata_http_put_response_hop_limit = number
    metadata_http_tokens                 = string
    metadata_instance_metadata_tags      = string

    root_block_device_delete_on_termination = bool
    root_block_device_encrypted             = bool
    root_block_device_iops                  = number
    root_block_device_volume_size           = number
    root_block_device_volume_type           = string
  }))
}

variable "eni_subnet_id" {
  description = "Subnet ID for the primary network interface"
  type        = string
}

variable "eni_private_ips" {
  description = "List of private IPs to assign to the ENI"
  type        = list(string)
}

variable "eni_security_groups" {
  description = "List of security group IDs to assign to the ENI"
  type        = list(string)
}

variable "eni_source_dest_check" {
  description = "Whether to enable source/destination checking on the ENI"
  type        = bool
}