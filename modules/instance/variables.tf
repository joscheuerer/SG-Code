variable "ami" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone to launch the instance in"
  type        = string
}

variable "key_name" {
  description = "Key pair name for the instance"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name to attach to the instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "source_dest_check" {
  description = "Whether to enable source/destination checking"
  type        = bool
}

variable "ebs_optimized" {
  description = "Whether the instance is EBS optimized"
  type        = bool
}

variable "monitoring" {
  description = "Whether detailed monitoring is enabled"
  type        = bool
}

variable "tenancy" {
  description = "Tenancy of the instance"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
}

variable "metadata_http_endpoint" {
  description = "Whether the metadata service is available"
  type        = string
}

variable "metadata_http_protocol_ipv6" {
  description = "Whether the IPv6 endpoint for IMDS is enabled"
  type        = string
}

variable "metadata_http_put_response_hop_limit" {
  description = "HTTP PUT response hop limit for instance metadata requests"
  type        = number
}

variable "metadata_http_tokens" {
  description = "Whether IMDSv2 is required"
  type        = string
}

variable "metadata_instance_metadata_tags" {
  description = "Whether instance tags are accessible via instance metadata"
  type        = string
}

variable "enclave_options_enabled" {
  description = "Whether Nitro Enclaves are enabled"
  type        = bool
}

variable "capacity_reservation_preference" {
  description = "Capacity reservation preference"
  type        = string
}

variable "root_block_device_delete_on_termination" {
  description = "Whether to delete root volume on termination"
  type        = bool
}

variable "root_block_device_volume_type" {
  description = "Root block device volume type"
  type        = string
}

variable "root_block_device_volume_size" {
  description = "Root block device volume size in GiB"
  type        = number
}

variable "root_block_device_encrypted" {
  description = "Whether the root block device is encrypted"
  type        = bool
}

variable "root_block_device_iops" {
  description = "IOPS for the root block device"
  type        = number
}

variable "tags" {
  description = "Tags to assign to the instance"
  type        = map(string)
}

variable "volume_tags" {
  description = "Tags to assign to volumes at instance creation"
  type        = map(string)
}