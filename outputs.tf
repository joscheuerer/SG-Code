output "virtual_network_id" {
  description = "The ID of the virtual network"
  value       = module.virtual_network.id
}

output "pbb_vm_nsg_id" {
  description = "The ID of the pbb-vm-nsg network security group"
  value       = module.network_security_group["pbb_vm_nsg"].id
}

output "private_runner_1_nsg_id" {
  description = "The ID of the private-runner-1-nsg network security group"
  value       = module.network_security_group["private_runner_1_nsg"].id
}

output "subnet2_id" {
  description = "The ID of subnet2"
  value       = module.subnet["subnet2"].id
}

output "subnet1_id" {
  description = "The ID of subnet1"
  value       = module.subnet["subnet1"].id
}

output "subnet3_id" {
  description = "The ID of subnet3"
  value       = module.subnet["subnet3"].id
}