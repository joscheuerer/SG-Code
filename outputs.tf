output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc_eks.igw_id
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = module.vpc_eks.igw_arn
}