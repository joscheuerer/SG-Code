variable "region" {
  type        = string
  description = "AWS region where resources will be managed"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
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
  description = "The IPv4 CIDR block for the subnet"
}

variable "subnet_availability_zone" {
  type        = string
  description = "AZ for the subnet"
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

variable "security_group_ingress" {
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
  description = "Ingress rules for the security group"
}

variable "security_group_egress" {
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
  description = "Egress rules for the security group"
}

variable "ebs_availability_zone" {
  type        = string
  description = "Availability zone where the EBS volume will exist"
}

variable "ebs_size" {
  type        = number
  description = "Size of the drive in GiBs"
}

variable "ebs_type" {
  type        = string
  description = "Type of EBS volume"
}

variable "ebs_iops" {
  type        = number
  description = "Amount of IOPS to provision for the disk"
}

variable "ebs_encrypted" {
  type        = bool
  description = "Whether the disk will be encrypted"
}

variable "ebs_multi_attach_enabled" {
  type        = bool
  description = "Whether to enable EBS Multi-Attach"
}

variable "ebs_snapshot_id" {
  type        = string
  description = "Snapshot ID to base the EBS volume off of"
}

variable "instance_ami" {
  type        = string
  description = "AMI to use for the instance"
}

variable "instance_instance_type" {
  type        = string
  description = "Instance type to use for the instance"
}

variable "instance_key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance"
}

variable "instance_availability_zone" {
  type        = string
  description = "AZ to start the instance in"
}

variable "instance_tenancy" {
  type        = string
  description = "Tenancy of the instance"
}

variable "instance_ebs_optimized" {
  type        = bool
  description = "Whether the launched EC2 instance will be EBS-optimized"
}

variable "instance_source_dest_check" {
  type        = bool
  description = "Controls if traffic is routed to the instance when the destination address does not match"
}

variable "instance_monitoring" {
  type        = bool
  description = "Whether the launched EC2 instance will have detailed monitoring enabled"
}

variable "instance_capacity_reservation_preference" {
  type        = string
  description = "Indicates the instance's Capacity Reservation preferences"
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
  description = "Whether Nitro Enclaves will be enabled on the instance"
}

variable "instance_metadata_http_endpoint" {
  type        = string
  description = "Whether the metadata service is available"
}

variable "instance_metadata_http_protocol_ipv6" {
  type        = string
  description = "Whether the IPv6 endpoint for the instance metadata service is enabled"
}

variable "instance_metadata_http_put_response_hop_limit" {
  type        = number
  description = "Desired HTTP PUT response hop limit for instance metadata requests"
}

variable "instance_metadata_http_tokens" {
  type        = string
  description = "Whether or not the metadata service requires session tokens"
}

variable "instance_metadata_instance_metadata_tags" {
  type        = string
  description = "Enables or disables access to instance tags from the instance metadata service"
}

variable "instance_root_block_device_delete_on_termination" {
  type        = bool
  description = "Whether the root volume should be destroyed on instance termination"
}

variable "eni_private_ips" {
  type        = list(string)
  description = "List of private IPs to assign to the ENI"
}

variable "eni_source_dest_check" {
  type        = bool
  description = "Whether to enable source destination checking for the ENI"
}

variable "eni_device_index" {
  type        = number
  description = "Integer to define the device index for the attachment"
}