output "vpc_id" {
  value       = aws_vpc.this.id
  description = "ID of the VPC"
}

output "owner_id" {
  value       = aws_vpc.this.owner_id
  description = "Owner ID of the VPC"
}