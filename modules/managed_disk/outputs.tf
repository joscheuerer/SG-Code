output "ids" {
  description = "Map of managed disk IDs keyed by the map key"
  value       = { for k, v in azurerm_managed_disk.this : k => v.id }
}