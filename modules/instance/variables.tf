variable "ami_id" {
  type        = string
  description = "AMI ID for the instance"
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
  description = "SSH key pair name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the instance"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs attached to the instance"
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
  description = "Enable hibernation"
}

variable "enclave_enabled" {
  type        = bool
  description = "Enable AWS Nitro Enclaves"
}

variable "metadata_http_endpoint" {
  type        = string
  description = "Metadata service HTTP endpoint state"
}

variable "metadata_http_tokens" {
  type        = string
  description = "Metadata service HTTP tokens requirement"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  description = "Metadata service HTTP PUT response hop limit"
}

variable "metadata_instance_metadata_tags" {
  type        = string
  description = "Enable instance metadata tags"
}

variable "cpu_core_count" {
  type        = number
  description = "Number of CPU cores"
}

variable "cpu_threads_per_core" {
  type        = number
  description = "Number of threads per CPU core"
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
  description = "Enable root volume encryption"
}

variable "root_volume_delete_on_termination" {
  type        = bool
  description = "Delete root volume on instance termination"
}