variable "region" {
  description = "AWS region"
  type        = string
}

variable "name" {
  description = "Name to be used on all resources as identifier"
  type        = string
}

variable "create_vpc" {
  description = "Controls if VPC should be created"
  type        = bool
}

variable "create_igw" {
  description = "Controls if an Internet Gateway is created"
  type        = bool
}

variable "create_egress_only_igw" {
  description = "Controls if an Egress Only Internet Gateway is created"
  type        = bool
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways"
  type        = bool
}

variable "create_flow_log_cloudwatch_iam_role" {
  description = "Whether to create IAM role for VPC Flow Logs"
  type        = bool
}

variable "create_flow_log_cloudwatch_log_group" {
  description = "Whether to create CloudWatch log group for VPC Flow Logs"
  type        = bool
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}