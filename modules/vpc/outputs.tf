output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID"
}

output "dhcp_options_id" {
  value       = aws_vpc.this.dhcp_options_id
  description = "DHCP options ID"
}