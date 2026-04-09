# lufthansa-network

Virtual network with AKS, application, and database subnets

## Architecture

This stack provisions an Azure virtual network with three subnets for AKS, application, and database workloads.

### Modules

#### virtual_network

Manages virtual network and associated subnets

**Resources:**
- `azurerm_virtual_network.this` - Virtual network
- `azurerm_subnet.this` - Subnets (for_each)

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | Azure region | - |
| subnets | map(object) | Subnets to create | - |

### subnets object structure

```hcl
{
  address_prefix = string
}
```

## Outputs

| Name | Description |
|------|-------------|
| virtual_network_id | Virtual network ID |
| virtual_network_name | Virtual network name |
| subnet_ids | Map of subnet names to IDs |

## Usage

### Initialize

```bash
tofu init
```

### Import Existing Resources

```bash
chmod +x imports.sh
./imports.sh tofu
```

### Plan

```bash
tofu plan -var-file=environments/terraform.tfvars
```

### Apply

```bash
tofu apply -var-file=environments/terraform.tfvars
```

## Configuration

Edit `environments/terraform.tfvars` to customize:
- Region
- Subnet definitions

The virtual network name, resource group, address space, and tags are hardcoded in `main.tf` as they are consistent across environments.