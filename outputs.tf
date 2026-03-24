output "launch_template_ids" {
  description = "Map of launch template IDs"
  value       = module.launch_templates.launch_template_ids
}

output "launch_template_arns" {
  description = "Map of launch template ARNs"
  value       = module.launch_templates.launch_template_arns
}