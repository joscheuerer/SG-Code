# Global Settings Infrastructure Documentation

## 1. Overview

This Terraform/OpenTofu configuration manages a suite of core Azure infrastructure resources spanning compute, networking, key management, and workflow automation. The code was generated from discovered cloud resources and underwent full reconciliation—all resources were imported into state until the final `plan` showed 0 changes to add, 0 to modify, 0 to destroy. This configuration is therefore a faithful, ready-to-deploy snapshot of the live infrastructure as of the scan date.

**Managed Resources:**
- 1 Linux virtual machine (`pr-of-the-galaxy`) with system-assigned managed identity, vTPM, and Secure Boot enabled
- 1 managed disk (OS disk for the VM, 30 GB Premium_LRS, Hyper-V V2, Trusted Launch enabled)
- 1 network interface attached to the VM with dynamic private IP and associated public IP address
- 1 Azure Key Vault (`testmenow`) configured for deployment and RBAC authorization
- 1 Logic App workflow (`ReadAuditLogs`) in disabled state for audit log collection

**Cloud Provider:** Microsoft Azure (subscription `a97621d8-9158-4681-81b6-38b1222afba4`)

## 2. Resources

| Terraform Address | Provider Type | Real-world Name/ID | Purpose |
|---|---|---|---|
| `module.managed_disk["pr_of_the_galaxy_osdisk"].azurerm_managed_disk.this` | `azurerm_managed_disk` | `pr-of-the-galaxy_OsDisk_1_80e28f24ebe24f8ea996a7737e43faeb` | OS disk for Linux VM; 30 GB Premium_LRS in zone 1, with Trusted Launch and Hyper-V V2 |
| `module.network_interface["pr_of_the_galaxy24_z1"].azurerm_network_interface.this` | `azurerm_network_interface` | `pr-of-the-galaxy24_z1` | Primary NIC for VM; connects to subnet and public IP; NSG applied |
| `module.linux_virtual_machine["pr_of_the_galaxy"].azurerm_linux_virtual_machine.this` | `azurerm_linux_virtual_machine` | `pr-of-the-galaxy` | Canonical Ubuntu 24.04 LTS (Standard_B2s); SystemAssigned identity; vTPM & Secure Boot enabled |
| `module.key_vault["testmenow"].azurerm_key_vault.this` | `azurerm_key_vault` | `testmenow` | Standard SKU vault in East US; RBAC authorization enabled; enabled for deployment |
| `module.logic_app_workflow["read_audit_logs"].azurerm_logic_app_workflow.this` | `azurerm_logic_app_workflow` | `ReadAuditLogs` | Disabled workflow in West Europe; triggers every 15 min (when enabled) to read audit logs via HTTP |

## 3. Module Structure

All resources are managed via local, single-resource modules under `modules/`. Each module wraps a single resource type and accepts a `for_each`-friendly input from the root.

### Module: `modules/managed_disk`
- **File:** `modules/managed_disk/main.tf`
- **Resource:** `azurerm_managed_disk.this`
- **Root Variable:** `managed_disks` (map of objects)
- **Key Variables:**
  - `name`, `resource_group_name`, `location` (required)
  - `storage_account_type`, `disk_size_gb` (required)
  - `create_option` (default: `"Empty"`)
  - `hyper_v_generation`, `trusted_launch_enabled`, `zone`, `os_type`, `tags` (optional)
- **Lifecycle:** `ignore_changes = [create_option, image_reference_id]` — OS disk created with `FromImage` at VM instantiation; these attributes are immutable after creation.

### Module: `modules/network_interface`
- **File:** `modules/network_interface/main.tf`
- **Resource:** `azurerm_network_interface.this`
- **Root Variable:** `network_interfaces` (map of objects)
- **Key Variables:**
  - `name`, `resource_group_name`, `location` (required)
  - `ip_configurations` (required; list of IP config objects)
  - `accelerated_networking_enabled`, `ip_forwarding_enabled` (default: `false`)
  - `network_security_group_id`, `tags` (optional)
- **Dynamic Blocks:** `ip_configuration` iterates over the `ip_configurations` list, allowing multiple IP configs per NIC.

### Module: `modules/linux_virtual_machine`
- **File:** `modules/linux_virtual_machine/main.tf`
- **Resource:** `azurerm_linux_virtual_machine.this`
- **Root Variable:** `linux_virtual_machines` (map of objects)
- **Key Variables:**
  - `name`, `resource_group_name`, `location`, `size`, `admin_username` (required)
  - `network_interface_ids`, `source_image_publisher`, `source_image_offer`, `source_image_sku` (required)
  - `disable_password_authentication` (default: `false`)
  - `zone`, `os_disk_name`, `os_disk_caching` (default: `"ReadWrite"`), `os_disk_storage_account_type` (default: `"Premium_LRS"`)
  - `source_image_version` (default: `"latest"`)
  - `identity_type`, `vtpm_enabled`, `secure_boot_enabled`, `tags` (optional)
- **Nested Blocks:**
  - `os_disk` — configures caching and storage type
  - `source_image_reference` — specifies publisher, offer, sku, version
  - `identity` — conditionally added if `identity_type` is not null
  - `additional_capabilities` — hard-coded with `ultra_ssd_enabled = false` and `hibernation_enabled = false` (required to match state)
  - `boot_diagnostics` — empty block (required; uses managed storage)
- **Lifecycle:** `ignore_changes = [admin_password]` — write-only attribute not returned by Azure API.

### Module: `modules/key_vault`
- **File:** `modules/key_vault/main.tf`
- **Resource:** `azurerm_key_vault.this`
- **Root Variable:** `key_vaults` (map of objects)
- **Key Variables:**
  - `name`, `resource_group_name`, `location`, `tenant_id`, `sku_name` (required)
  - `enabled_for_deployment`, `enabled_for_disk_encryption`, `enabled_for_template_deployment` (default: `false`)
  - `purge_protection_enabled` (default: `false`)
  - `soft_delete_retention_days` (default: `90`)
  - `enable_rbac_authorization` (default: `false`)
  - `tags` (optional)

### Module: `modules/logic_app_workflow`
- **File:** `modules/logic_app_workflow/main.tf`
- **Resource:** `azurerm_logic_app_workflow.this`
- **Root Variable:** `logic_app_workflows` (map of objects)
- **Key Variables:**
  - `name`, `resource_group_name`, `location` (required)
  - `workflow_schema` (default: `"https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#"`)
  - `workflow_version` (default: `"1.0.0.0"`)
  - `enabled` (default: `true`)
  - `parameters`, `tags` (optional, default: empty map/map)
  - `sg_api_key` (sensitive; passed from root variable)
- **Nested Blocks:**
  - `workflow_parameters` — hard-coded with `$connections` object (required)
- **Lifecycle:** `ignore_changes = [workflow_parameters, parameters]` — complex dynamic content managed outside Terraform (in Azure portal/API).

## 4. How Import Works

The `imports.sh` script contains five `terraform import` commands, one per resource. Each maps a Terraform module-qualified address to an Azure resource ID. The script was run once during initial setup to populate the state file from live cloud resources.

**Import commands (in `imports.sh`):**

```bash
terraform import -var-file environments/sg.tfvars \
  'module.managed_disk["pr_of_the_galaxy_osdisk"].azurerm_managed_disk.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Compute/disks/pr-of-the-galaxy_OsDisk_1_80e28f24ebe24f8ea996a7737e43faeb'

terraform import -var-file environments/sg.tfvars \
  'module.network_interface["pr_of_the_galaxy24_z1"].azurerm_network_interface.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Network/networkInterfaces/pr-of-the-galaxy24_z1'

terraform import -var-file environments/sg.tfvars \
  'module.linux_virtual_machine["pr_of_the_galaxy"].azurerm_linux_virtual_machine.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Compute/virtualMachines/pr-of-the-galaxy'

terraform import -var-file environments/sg.tfvars \
  'module.key_vault["testmenow"].azurerm_key_vault.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.KeyVault/vaults/testmenow'

terraform import -var-file environments/sg.tfvars \
  'module.logic_app_workflow["read_audit_logs"].azurerm_logic_app_workflow.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Logic/workflows/ReadAuditLogs'
```

**Do NOT re-run these commands** unless you deliberately lost state and need to re-populate it. To re-import a single resource (e.g., after state corruption):

```bash
terraform import -var-file environments/sg.tfvars 'module.linux_virtual_machine["pr_of_the_galaxy"].azurerm_linux_virtual_machine.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/jo-test/providers/Microsoft.Compute/virtualMachines/pr-of-the-galaxy'
```

**Pre-requisites for import:**
- Terraform state must not already contain the resource
- Your Azure credentials must have permission to read and import the resource
- All required variables must be set (via `-var-file` or `-var`)

## 5. How to Use the Code

### 5.1 Initialize Terraform

```bash
terraform init
```

This downloads the AzureRM provider (~> 3.0) and initializes the backend.

### 5.2 Validate and Plan

```bash
terraform plan -var-file=environments/sg.tfvars
```

This checks syntax, downloads provider plugins, and displays proposed changes. Given the code is reconciled, this should show 0 changes.

### 5.3 Apply (Deploy)

```bash
terraform apply -var-file=environments/sg.tfvars
```

Interactive prompt confirms before applying. Since plan is clean, this is idempotent and safe to re-run.

### 5.4 Target Another Environment

To deploy to a different environment (e.g., `dev`, `prod`):

1. **Copy the tfvars file:**
   ```bash
   cp environments/sg.tfvars environments/dev.tfvars
   ```

2. **Edit the new file** with dev-specific values (resource names, sizes, locations, IDs):
   ```bash
   vim environments/dev.tfvars
   ```

3. **Plan and apply with the new file:**
   ```bash
   terraform plan -var-file=environments/dev.tfvars
   terraform apply -var-file=environments/dev.tfvars
   ```

**No `.tf` file edits are required.** All configuration is data-driven via the tfvars file.

### 5.5 Destroy (Optional)

To tear down all managed resources:

```bash
terraform destroy -var-file=environments/sg.tfvars
```

## 6. Variables

### Root-level Variables

All resources are provisioned via `for_each` map inputs. Below are the key input variables and their sensitive status:

#### **`managed_disks`** — `map(object({...}))`
- **Type:** Map of disk configurations
- **Default:** `{}`
- **Sensitive:** No
- **Required fields per entry:** `name`, `resource_group_name`, `location`, `storage_account_type`, `disk_size_gb`
- **Optional fields:** `create_option`, `hyper_v_generation`, `trusted_launch_enabled`, `zone`, `os_type`, `tags`
- **Controls:** Managed disks inventory (e.g., OS disks for VMs)

#### **`network_interfaces`** — `map(object({...}))`
- **Type:** Map of NIC configurations
- **Default:** `{}`
- **Sensitive:** No
- **Required fields per entry:** `name`, `resource_group_name`, `location`, `ip_configurations` (list)
- **Optional fields:** `accelerated_networking_enabled`, `ip_forwarding_enabled`, `network_security_group_id`, `tags`
- **Controls:** Network interface attachments and IP configuration (subnets, public IPs, NSGs)

#### **`linux_virtual_machines`** — `map(object({...}))`
- **Type:** Map of VM configurations
- **Default:** `{}`
- **Sensitive:** No
- **Required fields per entry:** `name`, `resource_group_name`, `location`, `size`, `admin_username`, `network_interface_ids`, `source_image_publisher`, `source_image_offer`, `source_image_sku`
- **Optional fields:** `disable_password_authentication`, `zone`, `os_disk_name`, `os_disk_caching`, `os_disk_storage_account_type`, `source_image_version`, `identity_type`, `vtpm_enabled`, `secure_boot_enabled`, `tags`
- **Controls:** Compute instances, OS image selection, security features (vTPM, Secure Boot), identity type

#### **`key_vaults`** — `map(object({...}))`
- **Type:** Map of Key Vault configurations
- **Default:** `{}`
- **Sensitive:** No
- **Required fields per entry:** `name`, `resource_group_name`, `location`, `tenant_id`, `sku_name`
- **Optional fields:** `enabled_for_deployment`, `enabled_for_disk_encryption`, `enabled_for_template_deployment`, `purge_protection_enabled`, `soft_delete_retention_days`, `enable_rbac_authorization`, `tags`
- **Controls:** Secure secret/key storage, access policies, retention settings

#### **`logic_app_workflows`** — `map(object({...}))`
- **Type:** Map of Logic App workflow configurations
- **Default:** `{}`
- **Sensitive:** No
- **Required fields per entry:** `name`, `resource_group_name`, `location`
- **Optional fields:** `workflow_schema`, `workflow_version`, `enabled`, `parameters`, `tags`
- **Controls:** Integration workflow definitions, enable/disable state, custom parameters

#### **`sg_api_key`** — `string`
- **Type:** String
- **Default:** `""`
- **Sensitive:** **YES** ⚠️
- **Controls:** API key embedded in the Logic App workflow definition (HTTP Authorization header)
- **Status:** This variable must be supplied externally—it is **not included** in `environments/sg.tfvars`. See section 6.1 below.

### 6.1 Sensitive Variables & Secrets

**⚠️ CRITICAL:** The variable `sg_api_key` is marked `sensitive = true` and contains a credential used by the Logic App workflow. Its value is **deliberately not shipped** in the tfvars files.

**How to supply the secret:**

**Option A: Use `secrets.auto.tfvars` (recommended)**

1. Create a file `secrets.auto.tfvars` in the root directory (or any `.auto.tfvars` file not tracked in git):
   ```hcl
   sg_api_key = "sgu_lLRgHW3ciJiyG3joP1rxj"
   ```
2. When you run `plan` or `apply`, Terraform auto-loads `.auto.tfvars` files and applies the sensitive values.
3. **Ensure this file is in `.gitignore` to avoid committing secrets.**

**Option B: Pass via CLI**

```bash
terraform plan -var-file=environments/sg.tfvars -var='sg_api_key=sgu_lLRgHW3ciJiyG3joP1rxj'
```

**Option C: Use environment variable**

```bash
export TF_VAR_sg_api_key="sgu_lLRgHW3ciJiyG3joP1rxj"
terraform plan -var-file=environments/sg.tfvars
```

**⚠️ Security Note:** The API key (`sgu_lLRgHW3ciJiyG3joP1rxj`) is embedded in the Logic App definition (discovered in the workflow's HTTP action Authorization header). **Flag this key for rotation/masking upstream** to prevent unauthorized access to the audit log API.

## 7. Infrastructure Graph

```
module.linux_virtual_machine["pr_of_the_galaxy"]
├── azurerm_linux_virtual_machine.this (pr-of-the-galaxy)
│   ├── network_interface_ids → [module.network_interface["pr_of_the_galaxy24_z1"]]
│   └── os_disk references module.managed_disk["pr_of_the_galaxy_osdisk"]
│
module.network_interface["pr_of_the_galaxy24_z1"]
├── azurerm_network_interface.this (pr-of-the-galaxy24_z1)
│   ├── subnet_id = /subscriptions/.../virtualNetworks/jovnet-do-not-delete/subnets/subnet1
│   ├── public_ip_address_id = /subscriptions/.../publicIPAddresses/pr-of-the-galaxy-ip
│   └── network_security_group_id = /subscriptions/.../networkSecurityGroups/pr-of-the-galaxy-nsg
│
module.managed_disk["pr_of_the_galaxy_osdisk"]
├── azurerm_managed_disk.this (pr-of-the-galaxy_OsDisk_1_80e28f24ebe24f8ea996a7737e43faeb)
│   └── managed_by = pr-of-the-galaxy (VM)
│
module.key_vault["testmenow"]
├── azurerm_key_vault.this (testmenow)
│   └── (standalone; no child dependencies in managed resources)
│
module.logic_app_workflow["read_audit_logs"]
├── azurerm_logic_app_workflow.this (ReadAuditLogs)
│   └── (standalone workflow; contains hardcoded API endpoint and auth key)
```

**Reference Notes:**
- The Linux VM depends on the network interface and managed disk (via names/IDs in configuration).
- The network interface depends on external resources (subnet, public IP, NSG) not managed by this configuration; these are pre-existing or managed elsewhere.
- The Key Vault and Logic App have no dependencies within the managed resources; they are standalone.

## 8. Notable Decisions & Caveats

### 8.1 Lifecycle: `ignore_changes` Directives

**`azurerm_managed_disk` — `ignore_changes = [create_option, image_reference_id]`**
- **Reason:** OS disk is created with `create_option = "FromImage"` at the time the VM is instantiated. Azure does not allow these attributes to be changed after creation. Without `ignore_changes`, Terraform would detect drift between the configuration default (`"Empty"`) and the actual state (`"FromImage"`) and attempt (and fail) to modify the resource.
- **Impact:** These attributes cannot be changed via Terraform; they are immutable by design in Azure.

**`azurerm_linux_virtual_machine` — `ignore_changes = [admin_password]`**
- **Reason:** `admin_password` is a write-only attribute. The Azure API accepts it at creation/update but never returns it in API responses. Without `ignore_changes`, Terraform would think the value drifted to `null` on every plan and attempt to rewrite it.
- **Impact:** The password is not stored in state; once set (via import or initial apply), it cannot be read back. If you need to change the password, use Azure portal or Azure CLI directly, then refresh state.

**`azurerm_logic_app_workflow` — `ignore_changes = [workflow_parameters, parameters]`**
- **Reason:** The workflow definition and parameters are complex, often managed dynamically outside Terraform (via Azure portal connectors, runtime updates). These attributes can change between Terraform runs without being reflected in the tfvars file. `ignore_changes` prevents spurious "configuration has changed" errors.
- **Impact:** Changes to workflow parameters made in the Azure portal are preserved and not overwritten on the next Terraform apply.

### 8.2 Hard-coded Configuration Details

**`additional_capabilities` on Linux VM:**
```hcl
additional_capabilities {
  ultra_ssd_enabled   = false
  hibernation_enabled = false
}
```
- **Reason:** Azure returns these fields in the state even if not explicitly set. To achieve plan reconciliation (0 changes), they must be explicitly hard-coded in the configuration.
- **Impact:** Ultra-SSD and hibernation cannot be enabled for this VM via Terraform without modifying the module code.

**`boot_diagnostics` on Linux VM:**
```hcl
boot_diagnostics {}
```
- **Reason:** Empty block enables boot diagnostics with managed storage (Azure-managed storage account). Explicitly declaring it prevents drift.
- **Impact:** Boot diagnostics are always enabled; to disable, modify the module.

**`workflow_parameters` on Logic App:**
```hcl
workflow_parameters = {
  "$connections" = jsonencode({
    defaultValue = {}
    type         = "Object"
  })
}
```
- **Reason:** Logic Apps require the `$connections` parameter in the workflow parameters schema. This is hard-coded to match the Azure API expectations.
- **Impact:** This parameter cannot be customized per-instance; it is fixed by the module design.

### 8.3 Sensitive Attribute: API Key

The Logic App workflow definition contains an embedded API key in its HTTP action Authorization header:
```
Authorization: apikey sgu_lLRgHW3ciJiyG3joP1rxj
```

- **Current Status:** This key is stored in plain text in the Logic App's `definition` (readable via Azure portal / API). It is routed to the `sg_api_key` Terraform variable and passed to the module.
- **Security Recommendation:** This key should be rotated and masked at the API provider level. Consider using Azure Key Vault references or Managed Identity for the Logic App connector instead of a static API key.

### 8.4 RBAC Authorization Discovered Post-Generation

The `azurerm_key_vault` resource has `enable_rbac_authorization = true` in the state, discovered after the initial resource generation. This is explicitly set in `sg.tfvars` to match the live configuration.

### 8.5 External Dependency: Network Infrastructure

The network interface references external Azure resources that are **not managed by this configuration**:
- **Virtual Network:** `jovnet-do-not-delete` (subnet: `subnet1`)
- **Public IP:** `pr-of-the-galaxy-ip`
- **Network Security Group:** `pr-of-the-galaxy-nsg`

If these resources are deleted or modified outside Terraform, the network interface and VM will fail or become misconfigured. These should either be:
1. Managed by a separate Terraform configuration, or
2. Protected by Azure policies / resource locks.

### 8.6 VM Power State

The Linux VM is currently in a **deallocated** state (stopped, not running). Terraform does not manage power state; to start the VM, use Azure portal/CLI:
```bash
az vm start -g jo-test -n pr-of-the-galaxy
```

Terraform will not restart it on subsequent applies.

### 8.7 No Root-Level Outputs

The root `outputs.tf` file is empty (contains only a comment). This is intentional to avoid the "stale-null trap" with `for_each` modules: if a resource is removed from the map, outputs would unexpectedly become null, potentially breaking dependent configurations. Consumers should query state directly:
```bash
terraform state show 'module.linux_virtual_machine["pr_of_the_galaxy"].azurerm_linux_virtual_machine.this'
```

### 8.8 Reconciliation Status

- **Final Plan Result:** 0 to add, 0 to change, 0 to destroy
- **Date:** 2026-09-16 (scan date: 2025-06-30, import date: per handoff)
- **All resources imported and configuration aligned with live state**

