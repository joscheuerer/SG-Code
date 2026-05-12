output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = aws_vpc.this.default_network_acl_id
}