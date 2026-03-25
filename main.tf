module "bronze_ingest_dlq" {
  source = "./modules/sqs_queue"

  delay_seconds              = 0
  fifo_queue                 = false
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  sqs_managed_sse_enabled    = true
  visibility_timeout_seconds = 30
  tags = {
    Project      = "data-lake"
    ManagedBy    = "terraform"
    Architecture = "medallion"
    Environment  = "de-manuel-meireles"
    Purpose      = "dead-letter-queue"
    Layer        = "bronze"
    Name         = "de-manuel-meireles-bronze-ingest-dlq"
  }
}