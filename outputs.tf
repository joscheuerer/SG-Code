output "repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr_repository.repository_url
}

output "registry_id" {
  description = "The registry ID where the repository was created"
  value       = module.ecr_repository.registry_id
}

output "arn" {
  description = "Full ARN of the ECR repository"
  value       = module.ecr_repository.arn
}

output "name" {
  description = "Name of the ECR repository"
  value       = module.ecr_repository.name
}