variable "ami_id" {
  type        = string
  description = "AMI ID for the instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the instance"
}

variable "key_name" {
  type        = string
  description = "SSH key pair name"
}

variable "subnet_id" {
  type        = string
  description = "VPC subnet ID"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
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

variable "hibernation" {
  type        = bool
  description = "Enable hibernation support"
}

variable "enclave_enabled" {
  type        = bool
  description = "Enable Nitro Enclaves"
}

variable "metadata_http_endpoint" {
  type        = string
  description = "Metadata service HTTP endpoint state"
}

variable "metadata_http_tokens" {
  type        = string
  description = "Metadata service HTTP tokens requirement"
}

variable "metadata_hop_limit" {
  type        = number
  description = "Metadata service HTTP PUT response hop limit"
}

variable "metadata_instance_tags" {
  type        = string
  description = "Enable instance tags in metadata"
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
  description = "Root volume throughput in MB/s"
}

variable "root_volume_encrypted" {
  type        = bool
  description = "Encrypt root volume"
}

variable "root_delete_on_termination" {
  type        = bool
  description = "Delete root volume on instance termination"
}

variable "snapshot_id" {
  type        = string
  description = "Snapshot ID to create volume from"
}

variable "multi_attach_enabled" {
  type        = bool
  description = "Enable multi-attach for EBS volume"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}