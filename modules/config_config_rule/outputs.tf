output "rule_id" {
  description = "The ID of the Config rule"
  value       = aws_config_config_rule.this.rule_id
}

output "arn" {
  description = "The ARN of the Config rule"
  value       = aws_config_config_rule.this.arn
}