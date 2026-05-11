# azurenetwork-vnet-stack

## Description

Azure Virtual Network with three subnets (subnet1, subnet2, subnet3) in the azurenetwork resource group.

## Module Overview

| Module | Description |
|--------|-------------|
| `virtual_network` | Manages the Azure Virtual Network and its child subnets |

## Resources

| Resource Type | Name | Description |
|---------------|------|-------------|
| `azurerm_virtual_network` | `this` | The primary virtual network resource |
| `azurerm_subnet` | `this` (for_each) | Subnets created within the virtual network |

## Variables Reference

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `region` | `string` | The Azure region where resources will be deployed | — |
| `virtual_network_name` | `string` | The name of the virtual network | — |
| `resource_group_name` | `string` | The name of the resource group | — |
| `address_space` | `list(string)` | The address space used by the virtual network | — |
| `tags` | `map(string)` | A mapping of tags to assign to resources | `{}` |
| `subnets` | `map(object({...}))` | Map of subnets to create within the virtual network | `{}` |

## Outputs Reference

| Name | Description |
|------|-------------|
| `virtual_network_id` | The ID of the virtual network |
| `virtual_network_name` | The name of the virtual network |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import Existing Resources

```sh
./imports.sh terraform
```

Or with OpenTofu:

```sh
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

## Environment Configuration

The `environments/sg.tfvars` file contains the configuration for this stack:

- **Region**: eastus
- **Virtual Network**: azurenetworknet
- **Resource Group**: azurenetwork
- **Address Space**: 10.0.0.0/16
- **Subnets**: subnet1 (10.0.1.0/24), subnet2 (10.0.2.0/24), subnet3 (10.0.3.0/24)