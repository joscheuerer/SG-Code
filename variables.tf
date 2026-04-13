variable "region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "vpc_instance_tenancy" {
  type        = string
  description = "Tenancy option for instances launched into the VPC"
}

variable "vpc_enable_dns_support" {
  type        = bool
  description = "Whether DNS support is enabled in the VPC"
}

variable "vpc_tags" {
  type        = map(string)
  description = "Tags to apply to the VPC"
  default     = {}
}

variable "subnet_cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the subnet"
}

variable "subnet_availability_zone" {
  type        = string
  description = "The availability zone for the subnet"
}

variable "subnet_map_public_ip_on_launch" {
  type        = bool
  description = "Whether instances launched in this subnet receive a public IP"
}

variable "subnet_assign_ipv6_address_on_creation" {
  type        = bool
  description = "Whether IPv6 addresses are assigned on instance creation"
}

variable "subnet_tags" {
  type        = map(string)
  description = "Tags to apply to the subnet"
  default     = {}
}

variable "security_group_name" {
  type        = string
  description = "The name of the security group"
}

variable "security_group_description" {
  type        = string
  description = "Description of the security group"
}

variable "ebs_availability_zone" {
  type        = string
  description = "The availability zone in which to create the EBS volume"
}

variable "ebs_size" {
  type        = number
  description = "The size of the EBS volume in GiB"
}

variable "ebs_type" {
  type        = string
  description = "The type of the EBS volume"
}

variable "ebs_iops" {
  type        = number
  description = "The IOPS for the EBS volume"
}

variable "ebs_encrypted" {
  type        = bool
  description = "Whether the EBS volume is encrypted"
}

variable "ebs_multi_attach_enabled" {
  type        = bool
  description = "Whether multi-attach is enabled for the EBS volume"
}

variable "ebs_snapshot_id" {
  type        = string
  description = "The snapshot ID from which the EBS volume was created"
}

variable "instance_ami_id" {
  type        = string
  description = "The AMI ID for the EC2 instance"
}

variable "instance_instance_type" {
  type        = string
  description = "The EC2 instance type"
}

variable "instance_key_name" {
  type        = string
  description = "The key pair name to use for the instance"
}

variable "instance_vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the instance"
}

variable "instance_availability_zone" {
  type        = string
  description = "The availability zone for the instance"
}

variable "instance_source_dest_check" {
  type        = bool
  description = "Whether source/destination checking is enabled"
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
  description = "The tenancy of the instance"
}

variable "instance_private_ips" {
  type        = list(string)
  description = "Private IP addresses to assign to the network interface"
}