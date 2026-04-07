variable "ami_id" {
  type        = string
  description = "AMI ID to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the instance"
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the instance will be launched"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "ebs_optimized" {
  type        = bool
  description = "Whether the instance is EBS optimized"
}

variable "monitoring" {
  type        = bool
  description = "Whether detailed monitoring is enabled"
}

variable "source_dest_check" {
  type        = bool
  description = "Whether source/destination checking is enabled"
}

variable "tenancy" {
  type        = string
  description = "Tenancy of the instance"
}

variable "hibernation" {
  type        = bool
  description = "Whether hibernation is configured"
}

variable "metadata_http_endpoint" {
  type        = string
  description = "Whether the metadata service is available"
}

variable "metadata_http_tokens" {
  type        = string
  description = "Whether IMDSv2 is required"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  description = "Hop limit for metadata service requests"
}

variable "metadata_instance_metadata_tags" {
  type        = string
  description = "Whether instance tags are available via metadata"
}

variable "enclave_enabled" {
  type        = bool
  description = "Whether Nitro Enclaves are enabled"
}

variable "root_volume_type" {
  type        = string
  description = "Type of root volume"
}

variable "root_volume_size" {
  type        = number
  description = "Size of root volume in GiB"
}

variable "root_delete_on_termination" {
  type        = bool
  description = "Whether to delete root volume on termination"
}