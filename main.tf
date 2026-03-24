module "launch_templates" {
  source = "./modules/launch_template"

  launch_templates = var.launch_templates
}