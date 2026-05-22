variable "ami" {
  type        = string
  description = "AMI ID to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone to launch the instance in"
}

variable "key_name" {
  type        = string
  description = "Key pair name to use for the instance"
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile name to attach to the instance"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch the instance in"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the instance"
}

variable "source_dest_check" {
  type        = bool
  description = "Whether to enable source/destination check"
}

variable "ebs_optimized" {
  type        = bool
  description = "Whether the instance is EBS optimized"
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
  description = "Number of CPU cores"
}

variable "cpu_threads_per_core" {
  type        = number
  description = "Number of threads per CPU core"
}

variable "metadata_http_endpoint" {
  type        = string
  description = "Whether the metadata service HTTP endpoint is enabled"
}

variable "metadata_http_protocol_ipv6" {
  type        = string
  description = "Whether the IPv6 metadata endpoint is enabled"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  description = "HTTP PUT response hop limit for instance metadata requests"
}

variable "metadata_http_tokens" {
  type        = string
  description = "Whether IMDSv2 tokens are required"
}

variable "metadata_instance_metadata_tags" {
  type        = string
  description = "Whether instance metadata tags are enabled"
}

variable "enclave_options_enabled" {
  type        = bool
  description = "Whether Nitro Enclaves are enabled"
}

variable "root_block_device_delete_on_termination" {
  type        = bool
  description = "Whether the root block device is deleted on instance termination"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the instance"
}