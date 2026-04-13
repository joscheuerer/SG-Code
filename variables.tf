variable "region" {
  type        = string
  description = "AWS region where resources will be managed"
}

variable "vpc_cidr_block" {
  type        = string
  description = "IPv4 CIDR block for the VPC"
}

variable "vpc_instance_tenancy" {
  type        = string
  description = "Tenancy option for instances launched into the VPC"
}

variable "vpc_tags" {
  type        = map(string)
  description = "Tags to assign to the VPC"
}

variable "subnet_cidr_block" {
  type        = string
  description = "IPv4 CIDR block for the subnet"
}

variable "subnet_availability_zone" {
  type        = string
  description = "Availability zone for the subnet"
}

variable "subnet_map_public_ip_on_launch" {
  type        = bool
  description = "Whether to assign a public IP to instances launched in this subnet"
}

variable "subnet_assign_ipv6_address_on_creation" {
  type        = bool
  description = "Whether to assign IPv6 addresses on creation"
}

variable "subnet_tags" {
  type        = map(string)
  description = "Tags to assign to the subnet"
}

variable "security_group_name" {
  type        = string
  description = "Name of the security group"
}

variable "security_group_description" {
  type        = string
  description = "Description of the security group"
}

variable "ebs_volume_availability_zone" {
  type        = string
  description = "Availability zone where the EBS volume will exist"
}

variable "ebs_volume_size" {
  type        = number
  description = "Size of the EBS volume in GiB"
}

variable "ebs_volume_type" {
  type        = string
  description = "Type of EBS volume"
}

variable "ebs_volume_iops" {
  type        = number
  description = "Amount of IOPS to provision for the disk"
}

variable "ebs_volume_encrypted" {
  type        = bool
  description = "Whether the disk will be encrypted"
}

variable "ebs_volume_multi_attach_enabled" {
  type        = bool
  description = "Whether to enable EBS Multi-Attach"
}

variable "ebs_volume_snapshot_id" {
  type        = string
  description = "Snapshot ID to base the EBS volume off of"
}

variable "instance_ami" {
  type        = string
  description = "AMI ID to use for the instance"
}

variable "instance_instance_type" {
  type        = string
  description = "Instance type to use"
}

variable "instance_key_name" {
  type        = string
  description = "Key pair name for the instance"
}

variable "instance_availability_zone" {
  type        = string
  description = "Availability zone to start the instance in"
}

variable "instance_source_dest_check" {
  type        = bool
  description = "Whether to enable source/destination checking"
}

variable "instance_ebs_optimized" {
  type        = bool
  description = "Whether the instance is EBS-optimized"
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
  description = "Number of CPU cores for the instance"
}

variable "instance_cpu_threads_per_core" {
  type        = number
  description = "Number of threads per CPU core"
}

variable "instance_enclave_options_enabled" {
  type        = bool
  description = "Whether Nitro Enclaves are enabled"
}

variable "instance_metadata_http_endpoint" {
  type        = string
  description = "Whether the metadata service is available"
}

variable "instance_metadata_http_protocol_ipv6" {
  type        = string
  description = "Whether the IPv6 endpoint for IMDS is enabled"
}

variable "instance_metadata_http_put_response_hop_limit" {
  type        = number
  description = "HTTP PUT response hop limit for instance metadata requests"
}

variable "instance_metadata_http_tokens" {
  type        = string
  description = "Whether IMDSv2 session tokens are required"
}

variable "instance_metadata_instance_metadata_tags" {
  type        = string
  description = "Whether access to instance tags from IMDS is enabled"
}

variable "instance_root_block_device_delete_on_termination" {
  type        = bool
  description = "Whether the root volume is deleted on instance termination"
}

variable "eni_private_ips" {
  type        = list(string)
  description = "Private IP addresses to assign to the ENI"
}

variable "eni_source_dest_check" {
  type        = bool
  description = "Whether to enable source/destination checking for the ENI"
}

variable "eni_device_index" {
  type        = number
  description = "Device index for the ENI attachment"
}