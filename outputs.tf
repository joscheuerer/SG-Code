output "iam_role_arn" {
  description = "ARN of the Lambda execution IAM role"
  value       = module.iam_role.arn
}

output "iam_role_name" {
  description = "Name of the Lambda execution IAM role"
  value       = module.iam_role.name
}

output "s3_bucket_athena_results_id" {
  description = "ID of the Athena results S3 bucket"
  value       = module.s3_bucket["non_prod_infra_athena_results"].id
}

output "s3_bucket_lake_bronze_id" {
  description = "ID of the bronze layer S3 bucket"
  value       = module.s3_bucket["non_prod_infra_lake_bronze"].id
}

output "s3_bucket_lake_gold_id" {
  description = "ID of the gold layer S3 bucket"
  value       = module.s3_bucket["non_prod_infra_lake_gold"].id
}

output "s3_bucket_lake_silver_id" {
  description = "ID of the silver layer S3 bucket"
  value       = module.s3_bucket["non_prod_infra_lake_silver"].id
}

output "s3_bucket_landing_raw_id" {
  description = "ID of the landing raw S3 bucket"
  value       = module.s3_bucket["non_prod_infra_landing_raw"].id
}