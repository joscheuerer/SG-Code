variable "region" {
  type        = string
  description = "AWS region to deploy resources in"
}

variable "key_pair_key_name" {
  type        = string
  description = "Name of the EC2 key pair"
}

variable "key_pair_public_key" {
  type        = string
  description = "Public key material for the EC2 key pair"
  sensitive   = true
}

variable "iam_instance_profile_name" {
  type        = string
  description = "Name of the IAM instance profile"
}

variable "iam_instance_profile_path" {
  type        = string
  description = "Path for the IAM instance profile"
}

variable "iam_instance_profile_role" {
  type        = string
  description = "Name of the IAM role to associate with the instance profile"
}

variable "instance_ami" {
  type        = string
  description = "AMI ID to use for the EC2 instance"
}

variable "instance_instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "instance_availability_zone" {
  type        = string
  description = "Availability zone to launch the instance in"
}

variable "instance_subnet_id" {
  type        = string
  description = "Subnet ID to launch the instance in"
}

variable "instance_vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the instance"
}

variable "instance_source_dest_check" {
  type        = bool
  description = "Whether to enable source/destination check"
}

variable "instance_ebs_optimized" {
  type        = bool
  description = "Whether the instance is EBS optimized"
}

variable "instance_monitoring" {
  type        = bool
  description = "Whether detailed monitoring is enabled"
}

variable "instance_tenancy" {
  type        = string
  description = "Tenancy of the instance"
}

variable "instance_capacity_reservation_preference" {
  type        = string
  description = "Capacity reservation preference for the instance"
}

variable "instance_cpu_core_count" {
  type        = number
  description = "Number of CPU cores"
}

variable "instance_cpu_threads_per_core" {
  type        = number
  description = "Number of threads per CPU core"
}

variable "instance_metadata_http_endpoint" {
  type        = string
  description = "Whether the metadata service HTTP endpoint is enabled"
}

variable "instance_metadata_http_protocol_ipv6" {
  type        = string
  description = "Whether the IPv6 metadata endpoint is enabled"
}

variable "instance_metadata_http_put_response_hop_limit" {
  type        = number
  description = "HTTP PUT response hop limit for instance metadata requests"
}

variable "instance_metadata_http_tokens" {
  type        = string
  description = "Whether IMDSv2 tokens are required"
}

variable "instance_metadata_instance_metadata_tags" {
  type        = string
  description = "Whether instance metadata tags are enabled"
}

variable "instance_enclave_options_enabled" {
  type        = bool
  description = "Whether Nitro Enclaves are enabled"
}

variable "instance_root_block_device_delete_on_termination" {
  type        = bool
  description = "Whether the root block device is deleted on instance termination"
}

variable "instance_tags" {
  type        = map(string)
  description = "Tags to assign to the EC2 instance"
}