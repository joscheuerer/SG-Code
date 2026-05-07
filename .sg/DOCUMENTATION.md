# de-manuel-meireles-clickhouse-loader-monitoring

## Description

CloudWatch alarm monitoring ClickHouse loader Lambda errors for the de-manuel-meireles environment.

## Stack Overview

| Component | Details |
|-----------|---------|
| Stack Name | de-manuel-meireles-clickhouse-loader-monitoring |
| Region | eu-central-1 |
| Environment | de-manuel-meireles |

## Modules

### `cloudwatch_alarm` (`./modules/cloudwatch_alarm`)

Manages the CloudWatch alarm for ClickHouse loader Lambda error monitoring.

**Resources:**
| Resource Type | Logical Name | Description |
|---------------|--------------|-------------|
| `aws_cloudwatch_alarm` | `this` | CloudWatch alarm tracking Lambda Errors metric |

## Variables Reference

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `region` | `string` | AWS region to deploy resources | — |
| `alarm_name` | `string` | The name of the CloudWatch alarm | — |
| `alarm_description` | `string` | Description of the CloudWatch alarm | — |
| `actions_enabled` | `bool` | Whether actions should be executed during alarm state changes | — |
| `comparison_operator` | `string` | The arithmetic operation to use when comparing the statistic and threshold | — |
| `evaluation_periods` | `number` | The number of periods over which data is compared to the specified threshold | — |
| `metric_name` | `string` | The name of the metric associated with the alarm | — |
| `namespace` | `string` | The namespace for the alarm metric | — |
| `period` | `number` | The period in seconds over which the statistic is applied | — |
| `statistic` | `string` | The statistic to apply to the alarm metric | — |
| `threshold` | `number` | The value against which the specified statistic is compared | — |
| `treat_missing_data` | `string` | How to treat missing data points | — |
| `dimensions` | `map(string)` | The dimensions for the alarm metric | — |
| `tags` | `map(string)` | Tags to assign to the CloudWatch alarm | — |

## Outputs Reference

| Name | Description |
|------|-------------|
| `alarm_arn` | The ARN of the CloudWatch alarm |
| `alarm_name` | The name of the CloudWatch alarm |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import Existing Resources

```sh
./imports.sh terraform
# or for OpenTofu:
./imports.sh tofu
```

### 3. Plan

```sh
terraform plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```

## Alarm Configuration

| Setting | Value |
|---------|-------|
| Metric | `Errors` in `AWS/Lambda` namespace |
| Function | `de-manuel-meireles-clickhouse-loader-lambda` |
| Comparison | `GreaterThanThreshold` |
| Threshold | `0` |
| Evaluation Periods | `2` |
| Period | `60s` |
| Statistic | `Sum` |
| Missing Data | `notBreaching` |