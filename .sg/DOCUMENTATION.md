# pbb-network-stack

## Description

Azure virtual network with subnets and network security groups for the pbb environment.

## Stack Overview

This stack provisions the following Azure networking resources:

- **Virtual Network**: `pbbvnet` in resource group `pbb-rg` with address spaces `10.0.0.0/16` and `10.1.0.0/16`
- **Network Security Groups**: `pbb-vm-nsg` and `private-runner-1-nsg` with configurable inline security rules
- **Subnets**: `subnet1`, `subnet2`, and `subnet3` with optional service endpoints and delegations

## Module Overview

| Module | Description | Source |
|--------|-------------|--------|
| `virtual_network` | Manages the pbbvnet virtual network | `./modules/virtual_network` |
| `network_security_group` | Manages NSGs with optional inline security rules (for_each) | `./modules/network_security_group` |
| `subnet` | Manages subnets within the virtual network (for_each) | `./modules/subnet` |

## Variables Reference

| Variable | Type | Description | Default |
|----------|------|-------------|---------|
| `region` | `string` | The Azure region to deploy resources into | — |
| `virtual_network_name` | `string` | The name of the virtual network | — |
| `virtual_network_resource_group_name` | `string` | The resource group name for the virtual network | — |
| `virtual_network_address_space` | `list(string)` | The address space for the virtual network | — |
| `virtual_network_tags` | `map(string)` | Tags to assign to the virtual network | `{}` |
| `network_security_groups` | `map(object(...))` | Map of network security groups to create | `{}` |
| `subnets` | `map(object(...))` | Map of subnets to create | `{}` |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `virtual_network_id` | The ID of the virtual network |
| `pbb_vm_nsg_id` | The ID of the pbb-vm-nsg network security group |
| `private_runner_1_nsg_id` | The ID of the private-runner-1-nsg network security group |
| `subnet2_id` | The ID of subnet2 |
| `subnet1_id` | The ID of subnet1 |
| `subnet3_id` | The ID of subnet3 |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import Existing Resources

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

- The `subnet` module calls depend on `module.virtual_network` for the virtual network name — Terraform will automatically order the operations correctly.
- Security rules for NSGs are managed inline within the `azurerm_network_security_group` resource using dynamic blocks.
- Subnet delegations and service endpoints are optional and controlled per-subnet via the `subnets` variable.