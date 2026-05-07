region              = "eu-central-1"
alarm_name          = "de-manuel-meireles-clickhouse-loader-errors"
alarm_description   = "ClickHouse loader Lambda has errors — check CloudWatch Logs"
actions_enabled     = true
comparison_operator = "GreaterThanThreshold"
evaluation_periods  = 2
metric_name         = "Errors"
namespace           = "AWS/Lambda"
period              = 60
statistic           = "Sum"
threshold           = 0
treat_missing_data  = "notBreaching"

dimensions = {
  FunctionName = "de-manuel-meireles-clickhouse-loader-lambda"
}

tags = {
  Project      = "data-lake"
  Environment  = "de-manuel-meireles"
  Purpose      = "clickhouse-loader"
  ManagedBy    = "terraform"
  Architecture = "medallion"
}