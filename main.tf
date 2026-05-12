module "config_config_rule" {
  source = "./modules/config_config_rule"

  name                      = var.name
  description               = var.description
  evaluation_mode           = var.evaluation_mode
  compliance_resource_types = var.compliance_resource_types
  source_owner              = var.source_owner
  source_identifier         = var.source_identifier
}