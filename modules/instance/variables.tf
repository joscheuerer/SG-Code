variable "ami_id" {
  type        = string
  description = "The AMI ID for the instance"
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "The key pair name to use for the instance"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID in which to launch the instance"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the instance"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone for the instance"
}

variable "source_dest_check" {
  type        = bool
  description = "Whether source/destination checking is enabled"
}

variable "ebs_optimized" {
  type        = bool
  description = "Whether the instance is EBS-optimized"
}

variable "monitoring" {
  type        = bool
  description = "Whether detailed monitoring is enabled"
}

variable "tenancy" {
  type        = string
  description = "The tenancy of the instance"
}

variable "private_ips" {
  type        = list(string)
  description = "Private IP addresses to assign to the network interface"
}