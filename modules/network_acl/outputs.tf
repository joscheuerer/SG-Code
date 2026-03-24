output "network_acl_id" {
  value       = aws_default_network_acl.this.id
  description = "The ID of the network ACL"
}