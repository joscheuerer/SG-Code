resource "aws_config_config_rule" "this" {
  name             = var.name
  description      = var.description
  input_parameters = jsonencode({})

  evaluation_mode {
    mode = var.evaluation_mode
  }

  scope {
    compliance_resource_types = var.compliance_resource_types
  }

  source {
    owner             = var.source_owner
    source_identifier = var.source_identifier
  }
}