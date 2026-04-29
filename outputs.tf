output "nsg_id" {
  description = "The ID of the Network Security Group"
  value       = module.network_security_group.id
}

output "nic_id" {
  description = "The ID of the Network Interface"
  value       = module.network_interface.id
}

output "vm_id" {
  description = "The ID of the Virtual Machine"
  value       = module.virtual_machine.id
}