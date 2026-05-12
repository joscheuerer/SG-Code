output "network_acl_id" {
  description = "The ID of the network ACL"
  value       = aws_default_network_acl.this.id
}