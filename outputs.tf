output "instance_id" {
  value       = module.ubuntu_debugging.instance_id
  description = "EC2 instance ID"
}

output "instance_private_ip" {
  value       = module.ubuntu_debugging.instance_private_ip
  description = "EC2 instance private IP address"
}

output "volume_id" {
  value       = module.ubuntu_debugging.volume_id
  description = "EBS volume ID"
}