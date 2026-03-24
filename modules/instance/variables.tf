variable "ami" {
  type        = string
  description = "AMI ID for instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for instance"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for instance"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs"
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile ARN"
}

variable "source_dest_check" {
  type        = bool
  description = "Enable source/destination checking"
}

variable "ebs_optimized" {
  type        = bool
  description = "Enable EBS optimization"
}

variable "monitoring" {
  type        = bool
  description = "Enable detailed monitoring"
}

variable "tenancy" {
  type        = string
  description = "Instance tenancy"
}

variable "metadata_http_endpoint" {
  type        = string
  description = "Metadata service HTTP endpoint"
}

variable "metadata_http_tokens" {
  type        = string
  description = "Metadata service HTTP tokens requirement"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  description = "Metadata service HTTP PUT response hop limit"
}

variable "root_volume_type" {
  type        = string
  description = "Root volume type"
}

variable "root_volume_size" {
  type        = number
  description = "Root volume size in GB"
}

variable "root_volume_iops" {
  type        = number
  description = "Root volume IOPS"
}

variable "root_volume_throughput" {
  type        = number
  description = "Root volume throughput"
}

variable "root_volume_encrypted" {
  type        = bool
  description = "Encrypt root volume"
}

variable "root_volume_delete_on_termination" {
  type        = bool
  description = "Delete root volume on termination"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}