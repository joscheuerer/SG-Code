variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
}

variable "vpc_instance_tenancy" {
  description = "Tenancy option for instances launched into the VPC"
  type        = string
}

variable "vpc_tags" {
  description = "Tags to assign to the VPC"
  type        = map(string)
}

variable "subnet_cidr_block" {
  description = "The IPv4 CIDR block for the subnet"
  type        = string
}

variable "subnet_availability_zone" {
  description = "AZ for the subnet"
  type        = string
}

variable "subnet_assign_ipv6_address_on_creation" {
  description = "Whether to assign IPv6 address on creation"
  type        = bool
}

variable "subnet_map_public_ip_on_launch" {
  description = "Whether to map public IP on launch"
  type        = bool
}

variable "subnet_tags" {
  description = "Tags to assign to the subnet"
  type        = map(string)
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "security_group_description" {
  description = "Description of the security group"
  type        = string
}

variable "security_group_ingress" {
  description = "Ingress rules for the security group"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    description      = optional(string, "")
    ipv6_cidr_blocks = optional(list(string), [])
    prefix_list_ids  = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
}

variable "security_group_egress" {
  description = "Egress rules for the security group"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    description      = optional(string, "")
    ipv6_cidr_blocks = optional(list(string), [])
    prefix_list_ids  = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
}

variable "security_group_tags" {
  description = "Tags to assign to the security group"
  type        = map(string)
}

variable "key_pair_key_name" {
  description = "The name for the key pair"
  type        = string
}

variable "key_pair_public_key" {
  description = "The public key material"
  type        = string
  sensitive   = true
}

variable "iam_instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
}

variable "iam_instance_profile_path" {
  description = "Path to the instance profile"
  type        = string
}

variable "iam_instance_profile_role" {
  description = "Name of the IAM role to associate with the instance profile"
  type        = string
}

variable "ebs_volume_availability_zone" {
  description = "Availability zone where the EBS volume will exist"
  type        = string
}

variable "ebs_volume_size" {
  description = "Size of the drive in GiBs"
  type        = number
}

variable "ebs_volume_type" {
  description = "Type of EBS volume"
  type        = string
}

variable "ebs_volume_iops" {
  description = "Amount of IOPS to provision for the disk"
  type        = number
}

variable "ebs_volume_throughput" {
  description = "Throughput that the volume supports in MiB/s"
  type        = number
}

variable "ebs_volume_encrypted" {
  description = "Whether the disk will be encrypted"
  type        = bool
}

variable "ebs_volume_multi_attach_enabled" {
  description = "Whether to enable Amazon EBS Multi-Attach"
  type        = bool
}

variable "ebs_volume_snapshot_id" {
  description = "Snapshot ID to base the EBS volume off of"
  type        = string
}

variable "ebs_volume_tags" {
  description = "Tags to assign to the EBS volume"
  type        = map(string)
}

variable "network_interface_private_ips" {
  description = "List of private IPs to assign to the ENI"
  type        = list(string)
}

variable "network_interface_source_dest_check" {
  description = "Whether to enable source destination checking for the ENI"
  type        = bool
}

variable "network_interface_tags" {
  description = "Tags to assign to the ENI"
  type        = map(string)
}

variable "instance_ami" {
  description = "AMI to use for the instance"
  type        = string
}

variable "instance_instance_type" {
  description = "Instance type to use for the instance"
  type        = string
}

variable "instance_availability_zone" {
  description = "AZ to start the instance in"
  type        = string
}

variable "instance_source_dest_check" {
  description = "Controls if traffic is routed to the instance when destination address does not match"
  type        = bool
}

variable "instance_ebs_optimized" {
  description = "Whether the launched EC2 instance will be EBS-optimized"
  type        = bool
}

variable "instance_monitoring" {
  description = "Whether the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
}

variable "instance_tenancy" {
  description = "Tenancy of the instance"
  type        = string
}

variable "instance_metadata_http_endpoint" {
  description = "Whether the metadata service is available"
  type        = string
}

variable "instance_metadata_http_protocol_ipv6" {
  description = "Whether the IPv6 endpoint for the instance metadata service is enabled"
  type        = string
}

variable "instance_metadata_http_put_response_hop_limit" {
  description = "Desired HTTP PUT response hop limit for instance metadata requests"
  type        = number
}

variable "instance_metadata_http_tokens" {
  description = "Whether the metadata service requires session tokens"
  type        = string
}

variable "instance_metadata_instance_metadata_tags" {
  description = "Enables or disables access to instance tags from the instance metadata service"
  type        = string
}

variable "instance_enclave_options_enabled" {
  description = "Whether Nitro Enclaves will be enabled on the instance"
  type        = bool
}

variable "instance_capacity_reservation_preference" {
  description = "Indicates the instance's Capacity Reservation preferences"
  type        = string
}

variable "instance_root_block_device_delete_on_termination" {
  description = "Whether the root volume should be destroyed on instance termination"
  type        = bool
}

variable "instance_root_block_device_volume_size" {
  description = "Size of the root volume in GiB"
  type        = number
}

variable "instance_tags" {
  description = "Tags to assign to the instance"
  type        = map(string)
}