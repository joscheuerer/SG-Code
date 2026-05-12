# private-runner-sg-azure2-stack

## Description

Azure infrastructure for a private runner VM with network interface, public IP, managed OS disk, and network security group. All resources are deployed in the `eastus2` region within the `test` resource group.

## Architecture Overview

```
public_ip ──► network_interface ──► virtual_machine
                                         │
network_security_group                   │
                                         │
managed_disk ────────────────────────────┘
```

## Module Overview

| Module | Description | Primary Resource |
|--------|-------------|-----------------|
| `public_ip` | Manages the public IP address for the VM | `azurerm_public_ip` |
| `network_security_group` | Manages the NSG with custom security rules | `azurerm_network_security_group` |
| `network_interface` | Manages the NIC, wired to the public IP | `azurerm_network_interface` |
| `managed_disk` | Manages the OS managed disk | `azurerm_managed_disk` |
| `virtual_machine` | Manages the primary VM and its OS profile | `azurerm_virtual_machine` |

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | Azure region for the provider | — |
| `resource_group_name` | `string` | Resource group name | — |
| `location` | `string` | Azure region where resources exist | — |
| `vm_name` | `string` | Name of the virtual machine | — |
| `vm_size` | `string` | Size of the virtual machine | — |
| `vm_zones` | `list(string)` | Availability zones for the VM | — |
| `vm_tags` | `map(string)` | Tags to assign to the VM | — |
| `vm_os_disk_name` | `string` | Name of the OS disk | — |
| `vm_os_disk_create_option` | `string` | Create option for the OS disk | — |
| `vm_os_disk_caching` | `string` | Caching setting for the OS disk | — |
| `vm_os_type` | `string` | OS type for the OS disk | — |
| `vm_image_publisher` | `string` | Publisher of the VM image | — |
| `vm_image_offer` | `string` | Offer of the VM image | — |
| `vm_image_sku` | `string` | SKU of the VM image | — |
| `vm_image_version` | `string` | Version of the VM image | — |
| `vm_computer_name` | `string` | Computer name of the VM | — |
| `vm_admin_username` | `string` | Admin username for the VM | — |
| `vm_disable_password_authentication` | `bool` | Whether password authentication is disabled (sensitive) | `null` |
| `vm_boot_diagnostics_enabled` | `bool` | Whether boot diagnostics is enabled | — |
| `vm_boot_diagnostics_storage_uri` | `string` | Storage URI for boot diagnostics | — |
| `managed_disk_name` | `string` | Name of the managed disk | — |
| `managed_disk_storage_account_type` | `string` | Storage account type for the managed disk | — |
| `managed_disk_create_option` | `string` | Create option for the managed disk | — |
| `managed_disk_size_gb` | `number` | Size of the managed disk in GB | — |
| `managed_disk_os_type` | `string` | OS type for the managed disk | — |
| `nic_name` | `string` | Name of the network interface | — |
| `nic_accelerated_networking_enabled` | `bool` | Whether accelerated networking is enabled | — |
| `nic_ip_forwarding_enabled` | `bool` | Whether IP forwarding is enabled | — |
| `nic_ip_config_name` | `string` | Name of the IP configuration | — |
| `nic_private_ip_address_allocation` | `string` | Private IP address allocation method | — |
| `nic_private_ip_address_version` | `string` | Private IP address version | — |
| `nic_subnet_id` | `string` | ID of the subnet | — |
| `nic_ip_config_primary` | `bool` | Whether this is the primary IP configuration | — |
| `nsg_name` | `string` | Name of the network security group | — |
| `nsg_security_rules` | `list(object(...))` | List of custom security rules for the NSG | — |
| `public_ip_name` | `string` | Name of the public IP | — |
| `public_ip_allocation_method` | `string` | Allocation method for the public IP | — |
| `public_ip_sku` | `string` | SKU of the public IP | — |
| `public_ip_version` | `string` | IP version for the public IP | — |
| `public_ip_zones` | `list(string)` | Availability zones for the public IP | — |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `vm_id` | The ID of the virtual machine |
| `managed_disk_id` | The ID of the managed disk |
| `network_interface_id` | The ID of the network interface |
| `nsg_id` | The ID of the network security group |
| `public_ip_id` | The ID of the public IP |
| `public_ip_address` | The allocated public IP address |

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

- `vm_disable_password_authentication` is a sensitive variable. Set it via `TF_VAR_vm_disable_password_authentication` or a secrets manager rather than in the tfvars file.
- The NIC is wired to the public IP via a cross-module output reference (`module.public_ip.id`).
- The VM's `network_interface_ids` is constructed at the root level from `module.network_interface.id`.