# snipeit-fullstack-network

## Description

Virtual network and subnet infrastructure for the SnipeIT FullStack application in Germany West Central.

## Stack Overview

This stack provisions the core networking layer for the SnipeIT FullStack application, including a virtual network and its associated subnets in the `germanywestcentral` Azure region.

## Modules

| Module | Source | Description |
|--------|--------|-------------|
| `virtual_network` | `./modules/virtual_network` | Manages the full-stack virtual network (primary) and its app subnet (child) |

### Module: `virtual_network`

Provisions an `azurerm_virtual_network` resource and one or more `azurerm_subnet` resources within it. Subnets are created via `for_each` over the `subnets` input map.

**Resources managed:**
- `azurerm_virtual_network.this` — The primary virtual network
- `azurerm_subnet.this` (for_each) — Subnets within the virtual network

## Variables Reference

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `region` | `string` | The Azure region where resources will be deployed | — |
| `resource_group_name` | `string` | The name of the resource group | — |
| `virtual_network_name` | `string` | The name of the virtual network | — |
| `address_space` | `list(string)` | The address space used by the virtual network | — |
| `virtual_network_tags` | `map(string)` | A mapping of tags to assign to the virtual network | — |
| `subnets` | `map(object({address_prefixes=list(string)}))` | Map of subnets to create, keyed by subnet name | — |

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

### 2. Import existing resources

```sh
./imports.sh terraform
# or for OpenTofu:
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

## Environment Values (`environments/sg.tfvars`)

| Variable | Value |
|----------|-------|
| `region` | `germanywestcentral` |
| `resource_group_name` | `sg-rg-full` |
| `virtual_network_name` | `full-stack-vnet` |
| `address_space` | `["10.0.0.0/16"]` |
| `virtual_network_tags` | `{Project="SnipeIT-FullStack", Environment="dev", ManagedBy="Terraform"}` |
| `subnets` | `{app={address_prefixes=["10.0.2.0/24"]}}` |