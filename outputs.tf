output "stackguardian_connector_role_outputs" {
  description = "Outputs from the StackGuardian connector role stack"
  value       = module.cloudformation_stack["stackguardian_connector_role"].stack_outputs
}

output "vpc_1_outputs" {
  description = "Outputs from the vpc-1 stack"
  value       = module.cloudformation_stack["vpc_1"].stack_outputs
}

output "vpc_2_outputs" {
  description = "Outputs from the vpc-2 stack"
  value       = module.cloudformation_stack["vpc_2"].stack_outputs
}