variable "delay_seconds" {
  type        = number
  description = "Seconds to delay message delivery"
}

variable "fifo_queue" {
  type        = bool
  description = "Whether queue is FIFO"
}

variable "max_message_size" {
  type        = number
  description = "Maximum message size in bytes"
}

variable "message_retention_seconds" {
  type        = number
  description = "Message retention period in seconds"
}

variable "sqs_managed_sse_enabled" {
  type        = bool
  description = "Enable SQS-managed server-side encryption"
}

variable "visibility_timeout_seconds" {
  type        = number
  description = "Visibility timeout in seconds"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}