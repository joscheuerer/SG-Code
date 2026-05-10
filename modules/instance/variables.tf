variable "ami" {
  description = "AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type to use for the instance"
  type        = string
}

variable "subnet_id" {
  description = "VPC Subnet ID to launch the instance in"
  type        = string
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile name to launch the instance with"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "availability_zone" {
  description = "AZ to start the instance in"
  type        = string
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when destination address does not match"
  type        = bool
}

variable "ebs_optimized" {
  description = "Whether the launched EC2 instance will be EBS-optimized"
  type        = bool
}

variable "monitoring" {
  description = "Whether the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
}

variable "tenancy" {
  description = "Tenancy of the instance"
  type        = string
}

variable "metadata_http_endpoint" {
  description = "Whether the metadata service is available"
  type        = string
}

variable "metadata_http_protocol_ipv6" {
  description = "Whether the IPv6 endpoint for the instance metadata service is enabled"
  type        = string
}

variable "metadata_http_put_response_hop_limit" {
  description = "Desired HTTP PUT response hop limit for instance metadata requests"
  type        = number
}

variable "metadata_http_tokens" {
  description = "Whether the metadata service requires session tokens"
  type        = string
}

variable "metadata_instance_metadata_tags" {
  description = "Enables or disables access to instance tags from the instance metadata service"
  type        = string
}

variable "enclave_options_enabled" {
  description = "Whether Nitro Enclaves will be enabled on the instance"
  type        = bool
}

variable "capacity_reservation_preference" {
  description = "Indicates the instance's Capacity Reservation preferences"
  type        = string
}

variable "root_block_device_delete_on_termination" {
  description = "Whether the root volume should be destroyed on instance termination"
  type        = bool
}

variable "root_block_device_volume_size" {
  description = "Size of the root volume in GiB"
  type        = number
}

variable "tags" {
  description = "Tags to assign to the instance"
  type        = map(string)
}