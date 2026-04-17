variable "ami" {
  type        = string
  description = "AMI to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type to use for the instance"
}

variable "subnet_id" {
  type        = string
  description = "VPC Subnet ID to launch in"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with"
}

variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance"
}

variable "availability_zone" {
  type        = string
  description = "AZ to start the instance in"
}

variable "tenancy" {
  type        = string
  description = "Tenancy of the instance"
}

variable "source_dest_check" {
  type        = bool
  description = "Controls if traffic is routed to the instance when destination address does not match"
}

variable "ebs_optimized" {
  type        = bool
  description = "Whether the launched EC2 instance will be EBS-optimized"
}

variable "monitoring" {
  type        = bool
  description = "Whether the launched EC2 instance will have detailed monitoring enabled"
}

variable "metadata_http_endpoint" {
  type        = string
  description = "Whether the metadata service is available"
}

variable "metadata_http_protocol_ipv6" {
  type        = string
  description = "Whether the IPv6 endpoint for the instance metadata service is enabled"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  description = "Desired HTTP PUT response hop limit for instance metadata requests"
}

variable "metadata_http_tokens" {
  type        = string
  description = "Whether the metadata service requires session tokens"
}

variable "metadata_instance_metadata_tags" {
  type        = string
  description = "Enables or disables access to instance tags from the instance metadata service"
}

variable "capacity_reservation_preference" {
  type        = string
  description = "Indicates the instance's Capacity Reservation preferences"
}

variable "enclave_options_enabled" {
  type        = bool
  description = "Whether Nitro Enclaves will be enabled on the instance"
}

variable "root_block_device_delete_on_termination" {
  type        = bool
  description = "Whether the root volume should be destroyed on instance termination"
}