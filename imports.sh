#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.cloudwatch_alarm.aws_cloudwatch_alarm.this' 'de-manuel-meireles-clickhouse-loader-errors'