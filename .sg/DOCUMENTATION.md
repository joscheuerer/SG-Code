# arunim-host-0-nic-stack

## Description

Azure Network Interface for arunim-host-0 with static private IP and public IP association.

## Module Overview

| Module | Description |
|--------|-------------|
| `network_interface` | Manages the Azure Network Interface `arunim-host-0-nic` |

## Variables Reference

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `region` | `string` | The Azure region for the provider | — |
| `name` | `string` | The name of the Network Interface | — |
| `location` | `string` | The Azure region where the Network Interface should exist | — |
| `resource_group_name` | `string` | The name of the Resource Group | — |
| `accelerated_networking_enabled` | `bool` | Should Accelerated Networking be enabled | — |
| `ip_forwarding_enabled` | `bool` | Should IP Forwarding be enabled | — |
| `tags` | `map(string)` | A mapping of tags to assign to the resource | — |
| `ip_configuration_name` | `string` | Name used for the IP Configuration | — |
| `private_ip_address_version` | `string` | The IP Version to use for the IP Configuration | — |
| `private_ip_address_allocation` | `string` | The allocation method used for the Private IP Address | — |
| `private_ip_address` | `string` | The static private IP address | — |
| `subnet_id` | `string` | The ID of the Subnet where this Network Interface should be located | — |
| `public_ip_address_id` | `string` | The ID of the Public IP Address to associate with this NIC | — |
| `ip_configuration_primary` | `bool` | Is this the Primary IP Configuration | — |

## Outputs Reference

| Name | Description |
|------|-------------|
| `network_interface_id` | The ID of the Network Interface |
| `network_interface_mac_address` | The MAC address of the Network Interface |
| `network_interface_private_ip_address` | The first private IP address of the Network Interface |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import existing resources

```sh
sh imports.sh terraform
# or with OpenTofu:
sh imports.sh tofu
```

### 3. Plan

```sh
terraform plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```