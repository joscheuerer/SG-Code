output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID"
}

output "owner_id" {
  value       = aws_vpc.this.owner_id
  description = "VPC owner ID"
}