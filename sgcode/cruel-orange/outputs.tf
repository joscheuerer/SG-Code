output "vm_id" {
  description = "The ID of the virtual machine"
  value       = module.virtual_machine.id
}

output "managed_disk_id" {
  description = "The ID of the managed disk"
  value       = module.managed_disk.id
}

output "network_interface_id" {
  description = "The ID of the network interface"
  value       = module.network_interface.id
}

output "nsg_id" {
  description = "The ID of the network security group"
  value       = module.network_security_group.id
}

output "public_ip_id" {
  description = "The ID of the public IP"
  value       = module.public_ip.id
}

output "public_ip_address" {
  description = "The allocated public IP address"
  value       = module.public_ip.ip_address
}