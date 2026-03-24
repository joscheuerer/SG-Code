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
  description = "Key pair name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the instance"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs"
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
  description = "Tenancy of the instance"
}

variable "hibernation" {
  type        = bool
  description = "Enable hibernation"
}

variable "enclave_enabled" {
  type        = bool
  description = "Enable Nitro Enclaves"
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

variable "metadata_instance_metadata_tags" {
  type        = string
  description = "Enable instance metadata tags"
}

variable "capacity_reservation_preference" {
  type        = string
  description = "Capacity reservation preference"
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
  description = "Root volume size in GiB"
}

variable "root_volume_iops" {
  type        = number
  description = "Root volume IOPS"
}

variable "root_volume_throughput" {
  type        = number
  description = "Root volume throughput"
}

variable "root_delete_on_termination" {
  type        = bool
  description = "Delete root volume on instance termination"
}