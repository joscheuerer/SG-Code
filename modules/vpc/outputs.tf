output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "cidr_block" {
  value       = aws_vpc.this.cidr_block
  description = "The CIDR block of the VPC"
}