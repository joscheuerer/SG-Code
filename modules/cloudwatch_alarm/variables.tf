variable "alarm_name" {
  description = "The name of the CloudWatch alarm"
  type        = string
}

variable "alarm_description" {
  description = "Description of the CloudWatch alarm"
  type        = string
}

variable "actions_enabled" {
  description = "Whether actions should be executed during alarm state changes"
  type        = bool
}

variable "comparison_operator" {
  description = "The arithmetic operation to use when comparing the statistic and threshold"
  type        = string
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
  type        = number
}

variable "metric_name" {
  description = "The name of the metric associated with the alarm"
  type        = string
}

variable "namespace" {
  description = "The namespace for the alarm metric"
  type        = string
}

variable "period" {
  description = "The period in seconds over which the statistic is applied"
  type        = number
}

variable "statistic" {
  description = "The statistic to apply to the alarm metric"
  type        = string
}

variable "threshold" {
  description = "The value against which the specified statistic is compared"
  type        = number
}

variable "treat_missing_data" {
  description = "How to treat missing data points"
  type        = string
}

variable "dimensions" {
  description = "The dimensions for the alarm metric"
  type        = map(string)
}

variable "tags" {
  description = "Tags to assign to the CloudWatch alarm"
  type        = map(string)
}