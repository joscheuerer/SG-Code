resource "aws_cloudwatch_alarm" "this" {
  alarm_name          = var.alarm_name
  alarm_description   = var.alarm_description
  actions_enabled     = var.actions_enabled
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  treat_missing_data  = var.treat_missing_data
  dimensions          = var.dimensions
  tags                = var.tags
}