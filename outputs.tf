output "dlq_arn" {
  value       = module.bronze_ingest_dlq.queue_arn
  description = "ARN of the bronze ingest dead letter queue"
}

output "dlq_url" {
  value       = module.bronze_ingest_dlq.queue_url
  description = "URL of the bronze ingest dead letter queue"
}