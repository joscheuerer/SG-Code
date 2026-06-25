# Terraform/OpenTofu Infrastructure Documentation

## 1. Overview

This Terraform code manages Azure network interface resources discovered from your cloud environment. The infrastructure was:

1. **Generated** from discovered cloud resources using resource scanning.
2. **Imported** into Terraform state via `imports.sh` until all resources matched cloud reality.
3. **Reconciled** until `terraform plan` showed **0 to add, 0 to change, 0 to destroy** — infrastructure and configuration are synchronized.

The code manages a single Azure Network Interface (`azurerm_network_interface`) resource named `arunim-host-0-nic` deployed in the West Europe region. This network interface is associated with a virtual machine in a Desktop Virtualization host pool.

---

## 2. Resources

| Terraform Address | Provider Type | Real-World Name/ID | Purpose |
|---|---|---|---|
| `module.network_interface["arunim_host_0_nic"].azurerm_network_interface.this` | `azurerm_network_interface` | `arunim-host-0-nic` | Primary network interface for the `arunim-host-0` virtual machine, configured with static private IP (10.100.1.4) and a public IP address in the West Europe region |

---

## 3. Module Structure

### `modules/network_interface/`

**Purpose:** Encapsulates Azure network interface resource management with reusable configuration.

**Files:**
- `main.tf` — Declares `azurerm_network_interface` resource with dynamic IP configuration blocks
- `variables.tf` — Defines input variables for network interface properties
- `outputs.tf` — Exports network interface ID, name, and primary private IP address

**Call Pattern:** Root module (`main.tf`) instantiates this module via `for_each` loop over `var.network_interfaces` map. The single discovered resource is keyed as `"arunim_host_0_nic"`.

**Inputs:**
- `name` — Network interface name
- `resource_group_name` — Azure resource group
- `location` — Azure region
- `accelerated_networking_enabled` — (default: `false`) Enable accelerated networking
- `ip_forwarding_enabled` — (default: `false`) Enable IP forwarding
- `tags` — Resource tags (default: `{}`)
- `ip_configurations` — List of IP configuration blocks, each specifying:
  - `name` — IP configuration name
  - `private_ip_address` — Static private IP address
  - `private_ip_address_version` — IP version (default: `"IPv4"`)
  - `private_ip_address_allocation` — Allocation method (`"Static"` or `"Dynamic"`)
  - `primary` — Whether this is the primary IP configuration (default: `false`)
  - `public_ip_address_id` — (optional) Associated public IP address resource ID
  - `subnet_id` — Subnet resource ID

**Outputs:**
- `id` — Network interface Azure resource ID
- `name` — Network interface name
- `private_ip_address` — Primary private IP address

No external modules are used. This is a simple, locally-defined abstraction.

---

## 4. How Import Works

The `imports.sh` file contains a single `terraform import` command that maps the discovered resource to its Terraform state address:

```bash
#!/bin/sh
set -e
"$1" import -var-file environments/sg.tfvars \
  'module.network_interface["arunim_host_0_nic"].azurerm_network_interface.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Network/networkInterfaces/arunim-host-0-nic'
```

**How it works:**
1. The import command reads `environments/sg.tfvars` to populate variables.
2. It maps the cloud resource (Azure resource ID) to the Terraform address.
3. The resource state is fetched from Azure and stored in `terraform.tfstate`.
4. Once imported, subsequent `terraform plan` commands will manage this resource declaratively.

**If state is lost and you need to re-import:**
```bash
terraform import -var-file environments/sg.tfvars \
  'module.network_interface["arunim_host_0_nic"].azurerm_network_interface.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Network/networkInterfaces/arunim-host-0-nic'
```

The resource ID is the full Azure path; it is immutable and specific to the cloud environment. The Terraform address must match the `for_each` key in the root module.

---

## 5. How to Use the Code

### Initialize Terraform

```bash
terraform init
```

This downloads the Azurerm provider and initializes the local working directory.

### Plan Changes

```bash
terraform plan -var-file=environments/sg.tfvars
```

This produces a preview of any changes (additions, modifications, or deletions). For a synchronized infrastructure, this should show:
```
No changes. Your infrastructure matches the configuration.
```

### Apply Changes

```bash
terraform apply -var-file=environments/sg.tfvars
```

This applies any planned changes to the cloud. Confirm when prompted.

### Targeting Another Environment

To manage resources in a different Azure environment (e.g., dev → prod):

1. **Create a new tfvars file** for the target environment:
   ```bash
   cp environments/sg.tfvars environments/prod.tfvars
   ```

2. **Edit the new file** with target environment values:
   ```hcl
   subscription_id = "different-azure-subscription-id"
   
   network_interfaces = {
     "prod_host_0_nic" = {
       # ... updated configuration
     }
   }
   ```

3. **Plan and apply** using the new file:
   ```bash
   terraform plan -var-file=environments/prod.tfvars
   terraform apply -var-file=environments/prod.tfvars
   ```

**No `.tf` code edits are required** — all environment-specific data lives in `*.tfvars` files.

---

## 6. Variables

### Root-Level Variables

#### `subscription_id` (required)
- **Type:** `string`
- **Description:** Azure subscription ID
- **Value in `sg.tfvars`:** `"a97621d8-9158-4681-81b6-38b1222afba4"`
- **Purpose:** Authenticates Terraform to the target Azure subscription

#### `network_interfaces` (optional, default: `{}`)
- **Type:** `map(object({...}))`
- **Description:** Map of Azure network interfaces to manage, keyed by logical name
- **Structure:**
  - `name` (string, required) — Network interface resource name in Azure
  - `resource_group_name` (string, required) — Azure resource group
  - `location` (string, required) — Azure region
  - `accelerated_networking_enabled` (bool, optional, default: `false`) — Enable hardware acceleration
  - `ip_forwarding_enabled` (bool, optional, default: `false`) — Enable IP forwarding (routing)
  - `tags` (map(string), optional, default: `{}`) — Azure resource tags
  - `ip_configurations` (list of objects, required) — IP configurations:
    - `name` (string, required) — IP configuration name
    - `private_ip_address` (string, required) — Static private IP
    - `private_ip_address_version` (string, optional, default: `"IPv4"`)
    - `private_ip_address_allocation` (string, required) — `"Static"` or `"Dynamic"`
    - `primary` (bool, optional, default: `false`)
    - `public_ip_address_id` (string, optional, default: `null`) — Public IP resource ID
    - `subnet_id` (string, required) — Subnet resource ID

**Current value in `sg.tfvars`:**
```hcl
network_interfaces = {
  "arunim_host_0_nic" = {
    name                           = "arunim-host-0-nic"
    resource_group_name            = "arunim-test-resource-group"
    location                       = "westeurope"
    accelerated_networking_enabled = false
    ip_forwarding_enabled          = false
    tags = {
      "cm-resource-parent" = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourcegroups/arunim-test-resource-group/providers/Microsoft.DesktopVirtualization/hostpools/arunim-eu-vd-group"
    }
    ip_configurations = [
      {
        name                          = "ipconfig"
        private_ip_address            = "10.100.1.4"
        private_ip_address_version    = "IPv4"
        private_ip_address_allocation = "Static"
        primary                       = true
        public_ip_address_id          = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Network/publicIPAddresses/pip-egewg-westeurope-subnet1"
        subnet_id                     = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/dsgsdg/providers/Microsoft.Network/virtualNetworks/egewg/subnets/subnet1"
      }
    ]
  }
}
```

### Secret Variables

**None.** No credential-like values were discovered during code generation. All values are present in `environments/sg.tfvars`. There is no `secrets.auto.tfvars` file.

---

## 7. Infrastructure Graph

```
module.network_interface["arunim_host_0_nic"]
└── azurerm_network_interface.this (arunim-host-0-nic)
    ├── references → subnet (egewg/subnet1)
    ├── references → public IP (pip-egewg-westeurope-subnet1)
    └── attached to → virtual machine (arunim-host-0)
```

**Resource Dependencies:**
- **Subnet:** The network interface's primary IP configuration is attached to subnet `subnet1` in VNet `egewg` (resource group `dsgsdg`).
- **Public IP:** The primary IP configuration is associated with public IP address `pip-egewg-westeurope-subnet1` (in resource group `arunim-test-resource-group`).
- **Virtual Machine:** The network interface is attached as a network adapter to virtual machine `arunim-host-0` (in resource group `arunim-test-resource-group`).

These references are **read-only** in the Terraform configuration; the subnet, public IP, and virtual machine are managed externally and referenced by resource ID.

---

## 8. Notable Decisions & Caveats

### Attribute Mapping (azurerm Provider v4.x)

During code generation, the discovery system identified a mismatch between Azure API field names and Terraform azurerm provider v4.x argument names:

| Discovery Field | Terraform Argument | Reason |
|---|---|---|
| `enable_accelerated_networking` | `accelerated_networking_enabled` | Provider v4.x renamed boolean flags to use `_enabled` suffix |
| `enable_ip_forwarding` | `ip_forwarding_enabled` | Same v4.x naming convention |

This was corrected in iteration 2; iteration 1 failed validation with the old naming scheme.

### IP Configuration as Dynamic Block

The network interface module uses a `dynamic` block to handle variable-length IP configuration lists:

```hcl
dynamic "ip_configuration" {
  for_each = var.ip_configurations
  content {
    # ...
  }
}
```

This allows a single network interface to have multiple IP configurations. The discovered resource currently has one IP configuration named `ipconfig`.

### No lifecycle ignore_changes

No attributes require `lifecycle { ignore_changes }` blocks. The `azurerm_network_interface` resource is fully declarative; there are no write-only or computed-only fields that drift.

### External Resource References

The following Azure resources are **not managed by this code** but are **referenced** by resource ID:

1. **Subnet** (`/subscriptions/.../virtualNetworks/egewg/subnets/subnet1`) — pre-existing in resource group `dsgsdg`
2. **Public IP** (`/subscriptions/.../publicIPAddresses/pip-egewg-westeurope-subnet1`) — pre-existing in resource group `arunim-test-resource-group`
3. **Virtual Machine** (`/subscriptions/.../virtualMachines/arunim-host-0`) — managed elsewhere, linked to this NIC via `virtual_machine_id`

If these resources are deleted or modified outside Terraform, the network interface resource will detect drift at next `plan`.

### Resource Group and Location

The network interface is deployed to:
- **Resource Group:** `arunim-test-resource-group`
- **Region:** West Europe (`westeurope`)

Both are passed as input variables from the tfvars file; they are immutable after creation.

### Reconciliation Status

At final reconciliation:
- **State:** Imported successfully via `imports.sh`
- **Plan Result:** `0 to add, 0 to change, 0 to destroy`
- **Status:** ✓ Clean — infrastructure and Terraform configuration are synchronized

No manual edits to state or code were required beyond the initial provider v4.x attribute naming correction.
