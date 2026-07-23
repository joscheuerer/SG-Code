variable "ami" {
  type        = string
  description = "AMI ID for the instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch the instance in"
}

variable "key_name" {
  type        = string
  description = "Key pair name for the instance"
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile name to attach"
}

variable "source_dest_check" {
  type        = bool
  description = "Whether to enable source/destination check"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the instance"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the instance"
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
  description = "Whether IMDSv2 is required"
}

variable "metadata_instance_metadata_tags" {
  type        = string
  description = "Whether instance tags are accessible from instance metadata"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the instance"
}