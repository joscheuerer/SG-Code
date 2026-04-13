variable "ami" {
  type        = string
  description = "AMI ID to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type to use"
}

variable "key_name" {
  type        = string
  description = "Key pair name for the instance"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch the instance in"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the instance"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone to start the instance in"
}

variable "source_dest_check" {
  type        = bool
  description = "Whether to enable source/destination checking"
}

variable "ebs_optimized" {
  type        = bool
  description = "Whether the instance is EBS-optimized"
}

variable "monitoring" {
  type        = bool
  description = "Whether detailed monitoring is enabled"
}

variable "tenancy" {
  type        = string
  description = "Tenancy of the instance"
}

variable "capacity_reservation_preference" {
  type        = string
  description = "Capacity reservation preference for the instance"
}

variable "cpu_core_count" {
  type        = number
  description = "Number of CPU cores for the instance"
}

variable "cpu_threads_per_core" {
  type        = number
  description = "Number of threads per CPU core"
}

variable "enclave_options_enabled" {
  type        = bool
  description = "Whether Nitro Enclaves are enabled"
}

variable "metadata_http_endpoint" {
  type        = string
  description = "Whether the metadata service is available"
}

variable "metadata_http_protocol_ipv6" {
  type        = string
  description = "Whether the IPv6 endpoint for IMDS is enabled"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  description = "HTTP PUT response hop limit for instance metadata requests"
}

variable "metadata_http_tokens" {
  type        = string
  description = "Whether IMDSv2 session tokens are required"
}

variable "metadata_instance_metadata_tags" {
  type        = string
  description = "Whether access to instance tags from IMDS is enabled"
}

variable "root_block_device_delete_on_termination" {
  type        = bool
  description = "Whether the root volume is deleted on instance termination"
}