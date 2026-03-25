output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.private_runner_storage.bucket_id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.private_runner_storage.bucket_arn
}