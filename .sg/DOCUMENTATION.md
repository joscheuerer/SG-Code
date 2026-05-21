# private-runner-sg-azure2-stack

## Description

Azure infrastructure for a private runner VM with managed disk, network interface, network security group, and public IP. All resources are deployed in the `eastus2` region within the `test` resource group.

## Architecture Overview

```
public_ip  ──────────────────────────────────────────┐
                                                      ▼
network_security_group          network_interface (uses public_ip.id)
                                        │
                                        ▼
                              virtual_machine
                                        │
                              managed_disk (standalone OS disk)
```

## Module Overview

| Module | Description | Primary Resource |
|--------|-------------|-----------------|
| `public_ip` | Public IP address for the runner VM | `azurerm_public_ip` |
| `network_security_group` | NSG with SSH allow and deny-all inbound rules | `azurerm_network_security_group` |
| `network_interface` | NIC wired to subnet and public IP | `azurerm_network_interface` |
| `managed_disk` | Standalone OS managed disk | `azurerm_managed_disk` |
| `virtual_machine` | Private runner Linux VM | `azurerm_virtual_machine` |

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | Azure region for the provider | — |
| `resource_group_name` | `string` | Name of the resource group | — |
| `location` | `string` | Azure region where resources exist | — |
| `public_ip_name` | `string` | Name of the public IP resource | — |
| `public_ip_allocation_method` | `string` | Allocation method (Static/Dynamic) | — |
| `public_ip_sku` | `string` | SKU of the public IP | — |
| `public_ip_zones` | `list(string)` | Availability zones for the public IP | — |
| `nsg_name` | `string` | Name of the NSG | — |
| `nsg_security_rules` | `list(object)` | Security rules for the NSG | — |
| `nic_name` | `string` | Name of the NIC | — |
| `nic_accelerated_networking_enabled` | `bool` | Enable accelerated networking | — |
| `nic_ip_forwarding_enabled` | `bool` | Enable IP forwarding | — |
| `nic_ip_configuration_name` | `string` | Name of the IP configuration | — |
| `nic_subnet_id` | `string` | Subnet ID for the NIC | — |
| `nic_private_ip_address_allocation` | `string` | Private IP allocation method | — |
| `nic_private_ip_address_version` | `string` | IP version (IPv4/IPv6) | — |
| `nic_ip_configuration_primary` | `bool` | Is primary IP configuration | — |
| `managed_disk_name` | `string` | Name of the managed disk | — |
| `managed_disk_storage_account_type` | `string` | Storage account type | — |
| `managed_disk_create_option` | `string` | Disk creation method | — |
| `managed_disk_size_gb` | `number` | Disk size in GB | — |
| `managed_disk_os_type` | `string` | OS type on the disk | — |
| `vm_name` | `string` | Name of the VM | — |
| `vm_size` | `string` | VM size | — |
| `vm_zones` | `list(string)` | Availability zones for the VM | — |
| `vm_tags` | `map(string)` | Tags for the VM | — |
| `vm_image_publisher` | `string` | Image publisher | — |
| `vm_image_offer` | `string` | Image offer | — |
| `vm_image_sku` | `string` | Image SKU | — |
| `vm_image_version` | `string` | Image version | — |
| `vm_os_disk_name` | `string` | OS disk name | — |
| `vm_os_disk_caching` | `string` | OS disk caching | — |
| `vm_os_disk_create_option` | `string` | OS disk create option | — |
| `vm_os_disk_managed_disk_type` | `string` | OS disk managed disk type | — |
| `vm_os_type` | `string` | OS type | — |
| `vm_computer_name` | `string` | Computer name | — |
| `vm_admin_username` | `string` | Admin username | — |
| `vm_disable_password_authentication` | `bool` (sensitive) | Disable password auth | — |
| `vm_boot_diagnostics_enabled` | `bool` | Enable boot diagnostics | — |
| `vm_boot_diagnostics_storage_uri` | `string` | Boot diagnostics storage URI | — |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `public_ip_id` | The ID of the public IP |
| `nsg_id` | The ID of the network security group |
| `nic_id` | The ID of the network interface |
| `managed_disk_id` | The ID of the managed disk |
| `virtual_machine_id` | The ID of the virtual machine |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import existing resources

```sh
./imports.sh terraform
# or with OpenTofu:
./imports.sh tofu
```

### 3. Plan

```sh
terraform plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```

## Notes

- `vm_disable_password_authentication` is marked sensitive. Set it in a `.tfvars` file or via environment variable `TF_VAR_vm_disable_password_authentication`.
- The NIC is wired to the public IP via cross-module output: `module.public_ip.id`.
- The VM's `network_interface_ids` is constructed at root level from `module.network_interface.id`.