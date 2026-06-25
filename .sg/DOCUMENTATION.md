# Infrastructure Documentation: Windows Virtual Machine & Extensions

**Generated from:** Auto-codified Azure resources  
**Status:** Reconciled — plan shows 0 to add, 0 to change, 0 to destroy  
**Working Directory:** `/mnt/sg_workspace/user/global-settings`  
**Last Updated:** 2026-06-25

---

## 1. Overview

This Terraform/OpenTofu configuration codifies a single **Windows 10 Enterprise virtual machine** (`arunim-host-0`) deployed to Azure in the `arunim-test-resource-group` resource group (West Europe region). The VM serves as a session host for Azure Virtual Desktop, indicated by the tag linking it to the host pool `arunim-eu-vd-group`.

The infrastructure code was **generated from discovered cloud resources**, imported into Terraform state, and reconciled until `plan` reported no changes (0/0/0). The VM and its two extensions (AAD login and PowerShell DSC for desktop virtualization configuration) are now fully codified and under Terraform management.

---

## 2. Resources

All resources are managed via a single module invocation with `for_each`. The discovered and imported resources are:

| Terraform Address | Provider Type | Cloud ID / Name | Purpose |
|---|---|---|---|
| `module.windows_virtual_machine["arunim_host_0"].azurerm_windows_virtual_machine.this` | `azurerm_windows_virtual_machine` | `arunim-host-0` | Windows 10 Enterprise (22H2) VM; Standard_D2s_v3 size; System-assigned managed identity; boot diagnostics enabled |
| `module.windows_virtual_machine["arunim_host_0"].azurerm_virtual_machine_extension.this["aad_login"]` | `azurerm_virtual_machine_extension` | `AADLoginForWindows` (v2.0) | Azure AD login extension; enables Azure AD authentication to the VM |
| `module.windows_virtual_machine["arunim_host_0"].azurerm_virtual_machine_extension.this["dsc"]` | `azurerm_virtual_machine_extension` | `Microsoft.PowerShell.DSC` (v2.73) | PowerShell Desired State Configuration; configures VM as Windows Virtual Desktop session host with registration to `arunim-eu-vd-group` |

---

## 3. Module Structure

### Root Module (`./`)

**Files:**
- `main.tf` — Instantiates `module.windows_virtual_machine` with `for_each` over `var.windows_virtual_machines` (map key: `arunim_host_0`)
- `variables.tf` — Defines top-level variables: `subscription_id`, `vm_admin_passwords` (sensitive), and `windows_virtual_machines` (map of VM configurations)
- `providers.tf` — Configures Azure provider with subscription ID from variables
- `versions.tf` — Declares required provider: `azurerm`
- `outputs.tf` — Currently empty (for_each modules do not expose singleton outputs)

### Module: `modules/windows_virtual_machine/`

**Purpose:** Encapsulates a single Windows virtual machine with optional extensions.

**Files:**
- `main.tf` — Contains:
  - `azurerm_windows_virtual_machine.this` — VM resource with lifecycle rule to ignore `admin_password` changes (write-only)
  - `azurerm_virtual_machine_extension.this` — Extensions loop (for_each) with lifecycle rule to ignore `settings` and `protected_settings` (ephemeral DSC tokens)
- `variables.tf` — 16 input variables covering VM compute/image/boot/patch/identity/extension configuration
- `outputs.tf` — Exports `id` (VM resource ID) and `private_ip_addresses`

**Called by:** Root module as `module.windows_virtual_machine` with `for_each = var.windows_virtual_machines`

---

## 4. How Import Works

The `imports.sh` script contains three import commands that populate Terraform state with existing Azure resources. Each command uses the syntax:

```bash
tofu import -var-file environments/sg.tfvars '<terraform-address>' '<azure-resource-id>'
```

### Import Commands

1. **VM Import:**
   ```bash
   tofu import -var-file environments/sg.tfvars \
     'module.windows_virtual_machine["arunim_host_0"].azurerm_windows_virtual_machine.this' \
     '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Compute/virtualMachines/arunim-host-0'
   ```

2. **AAD Extension Import:**
   ```bash
   tofu import -var-file environments/sg.tfvars \
     'module.windows_virtual_machine["arunim_host_0"].azurerm_virtual_machine_extension.this["aad_login"]' \
     '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Compute/virtualMachines/arunim-host-0/extensions/aadloginforwindows'
   ```

3. **DSC Extension Import:**
   ```bash
   tofu import -var-file environments/sg.tfvars \
     'module.windows_virtual_machine["arunim_host_0"].azurerm_virtual_machine_extension.this["dsc"]' \
     '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Compute/virtualMachines/arunim-host-0/extensions/microsoft.powershell.dsc'
   ```

### Re-importing a Single Resource

If state is lost or needs to be refreshed, re-import using the same address and Azure resource ID:

```bash
tofu import -var-file environments/sg.tfvars \
  'module.windows_virtual_machine["arunim_host_0"].azurerm_windows_virtual_machine.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/resourceGroups/arunim-test-resource-group/providers/Microsoft.Compute/virtualMachines/arunim-host-0'
```

The import script was **run once** during codification and need not be re-run under normal circumstances. State is persisted in the backend.

---

## 5. How to Use the Code

### Initialize Terraform

```bash
cd /mnt/sg_workspace/user/global-settings
tofu init
```

This downloads the Azure provider and initializes the Terraform backend.

### Plan Changes

To review what Terraform will do:

```bash
tofu plan -var-file=environments/sg.tfvars
```

Expected output: **No changes** (0 to add, 0 to change, 0 to destroy) — infrastructure matches configuration.

### Apply Changes

To apply (if any changes are planned):

```bash
tofu apply -var-file=environments/sg.tfvars
```

### Targeting Multiple Environments

To manage another environment (e.g., `prod` or `dev`), without editing `.tf` code:

1. **Copy and edit the tfvars file:**
   ```bash
   cp environments/sg.tfvars environments/prod.tfvars
   ```

2. **Edit the new file** to change:
   - `subscription_id`
   - VM name and resource group
   - Location, size, image details
   - Admin username and tags

3. **Plan and apply with the new file:**
   ```bash
   tofu plan -var-file=environments/prod.tfvars
   tofu apply -var-file=environments/prod.tfvars
   ```

No `.tf` code changes required; all configuration lives in `.tfvars`.

### Handling Admin Password

The VM admin password is sensitive and lives in `secrets.auto.tfvars` (which is auto-loaded by Terraform and excluded from version control):

```hcl
vm_admin_passwords = {
  "arunim_host_0" = "Placeholder!Ignored1"
}
```

**Before a real apply:**
- Replace the placeholder `"Placeholder!Ignored1"` with the actual admin password.
- Alternatively, pass it via command-line:
  ```bash
  tofu apply -var-file=environments/sg.tfvars -var='vm_admin_passwords={"arunim_host_0"="RealPassword123"}'
  ```

---

## 6. Variables

### Required Variables

#### `subscription_id` (string)
- **Description:** Azure subscription ID
- **Type:** `string`
- **Default:** None — must be supplied
- **Source:** `environments/sg.tfvars`
- **Value:** `a97621d8-9158-4681-81b6-38b1222afba4`

#### `windows_virtual_machines` (map of objects)
- **Description:** Map of Windows virtual machines to create
- **Type:** `map(object({...}))`
- **Default:** None — must be supplied
- **Source:** `environments/sg.tfvars`
- **Current Key:** `arunim_host_0`
- **Sub-attributes:**
  - `name` (string) — VM name; e.g., `arunim-host-0`
  - `resource_group_name` (string) — Azure resource group name; e.g., `arunim-test-resource-group`
  - `location` (string) — Azure region; e.g., `westeurope`
  - `size` (string) — VM size; e.g., `Standard_D2s_v3`
  - `admin_username` (string) — Admin user; e.g., `arunim`
  - `network_interface_ids` (list of strings) — Existing NIC IDs
  - `os_disk_name` (string) — OS disk name
  - `os_disk_caching` (string) — `ReadWrite` or `None`; default: `ReadWrite`
  - `os_disk_storage_account_type` (optional string, default: `StandardSSD_LRS`)
  - `os_disk_create_option` (string) — `FromImage` or `Import`
  - `license_type` (optional string, default: `null`) — `Windows_Client` for AVD
  - `ultra_ssd_enabled` (optional bool, default: `false`)
  - `hibernation_enabled` (optional bool, default: `false`)
  - `image_publisher` (string) — `microsoftwindowsdesktop`, `microsoftwindowsserver`, etc.
  - `image_offer` (string) — `windows-10`, `windows-11`, `windowsserver`, etc.
  - `image_sku` (string) — `win10-22h2-ent-g2`, `win11-22h2-pro-g2`, etc.
  - `image_version` (optional string, default: `latest`)
  - `identity_type` (optional string, default: `SystemAssigned`) — `SystemAssigned` or `UserAssigned`
  - `boot_diagnostics_enabled` (optional bool, default: `false`)
  - `boot_diagnostics_storage_uri` (optional string, default: `null`) — If `null`, uses managed storage
  - `patch_mode` (optional string, default: `AutomaticByOS`) — `AutomaticByOS`, `ManualOnly`, `ImageDefault`
  - `assessment_mode` (optional string, default: `ImageDefault`) — `ImageDefault` or `AutomaticByOS`
  - `tags` (optional map of strings, default: `{}`)
  - `extensions` (optional map of extension objects, default: `{}`)
    - Extension sub-attributes:
      - `name` (string) — Extension name; e.g., `aadloginforwindows`
      - `publisher` (string) — e.g., `Microsoft.Azure.ActiveDirectory`
      - `type` (string) — e.g., `AADLoginForWindows`
      - `type_handler_version` (string) — e.g., `2.0`
      - `auto_upgrade_minor_version` (optional bool, default: `true`)
      - `settings` (optional string, default: `null`) — JSON-encoded extension settings

### Sensitive Variables

#### `vm_admin_passwords` (map of strings, **sensitive**)
- **Description:** Map of VM key → admin password
- **Type:** `map(string)`
- **Sensitive:** Yes — values are masked in logs and state
- **Default:** `{}`
- **Source:** `secrets.auto.tfvars` (auto-loaded, **must not be committed to version control**)
- **Current Value:** `{"arunim_host_0" = "Placeholder!Ignored1"}`
- **⚠️ CRITICAL:** This is a placeholder value. **Before any real `apply`:**
  - Replace with the actual admin password, or
  - Pass via `-var` flag, or
  - Set environment variable `TF_VAR_vm_admin_passwords`
  - The password is write-only in Azure; once set, it is never returned by the API and cannot be read back.

---

## 7. Infrastructure Graph

```
module.windows_virtual_machine["arunim_host_0"]
├── azurerm_windows_virtual_machine.this
│   ├── name: arunim-host-0
│   ├── size: Standard_D2s_v3
│   ├── admin_username: arunim
│   ├── admin_password: (ignored in lifecycle)
│   ├── resource_group_name: arunim-test-resource-group
│   ├── location: westeurope
│   ├── os_disk
│   │   ├── name: arunim-host-0_OsDisk_1_498f48af84094a03a30c1a9efe99c319
│   │   ├── caching: ReadWrite
│   │   └── storage_account_type: StandardSSD_LRS
│   ├── source_image_reference
│   │   ├── publisher: microsoftwindowsdesktop
│   │   ├── offer: windows-10
│   │   ├── sku: win10-22h2-ent-g2
│   │   └── version: latest
│   ├── identity
│   │   └── type: SystemAssigned
│   ├── boot_diagnostics
│   │   └── storage_account_uri: null (managed)
│   ├── patch_mode: AutomaticByOS
│   ├── patch_assessment_mode: ImageDefault
│   ├── license_type: Windows_Client
│   ├── additional_capabilities
│   │   ├── ultra_ssd_enabled: false
│   │   └── hibernation_enabled: false
│   ├── tags
│   │   └── cm-resource-parent: /subscriptions/.../hostpools/arunim-eu-vd-group
│   ├── network_interface_ids
│   │   └── (referenced, not managed: /subscriptions/.../networkInterfaces/arunim-host-0-nic)
│   ├── os_disk_create_option: FromImage (implicitly managed)
│   │   └── (references, not managed: azurerm_managed_disk for OS disk)
│   └── extensions (for_each loop)
│       ├── azurerm_virtual_machine_extension.this["aad_login"]
│       │   ├── name: aadloginforwindows
│       │   ├── publisher: Microsoft.Azure.ActiveDirectory
│       │   ├── type: AADLoginForWindows
│       │   ├── type_handler_version: 2.0
│       │   ├── settings: null (ignored in lifecycle)
│       │   └── virtual_machine_id: (references azurerm_windows_virtual_machine.this.id)
│       └── azurerm_virtual_machine_extension.this["dsc"]
│           ├── name: microsoft.powershell.dsc
│           ├── publisher: Microsoft.Powershell
│           ├── type: DSC
│           ├── type_handler_version: 2.73
│           ├── settings: null (ignored in lifecycle)
│           └── virtual_machine_id: (references azurerm_windows_virtual_machine.this.id)
```

**Dependencies:**
- The Windows VM depends on the network interface (pre-existing; not managed)
- Each extension depends on the Windows VM (implicit reference via `virtual_machine_id`)
- No cyclic dependencies

---

## 8. Notable Decisions & Caveats

### Lifecycle Rules

#### 1. `azurerm_windows_virtual_machine.this` — `ignore_changes = [admin_password]`

**Reason:** The `admin_password` is write-only in Azure. Once the VM is created, the API never returns the password in subsequent reads. Without this rule, Terraform would see the password in state but not in Azure, causing spurious drift and forcing VM recreation.

**How it works:** Terraform accepts the initial password during creation but ignores any subsequent changes to it in future `plan`/`apply` cycles. If the real password must be rotated, it must be done through Azure Portal, CLI, or by destroying and recreating the VM.

#### 2. `azurerm_virtual_machine_extension.this` — `ignore_changes = [settings, protected_settings]`

**Reason:** The DSC extension settings contain ephemeral registration tokens that are rotated server-side by the Windows Virtual Desktop service. The settings are returned as encrypted `protected_settings` by the API, and comparing them with the tfvars (which has `null`) causes spurious drift.

**How it works:** Extensions are created with their initial settings but subsequent reads ignore changes to `settings` and `protected_settings`. The extension remains stable and will not be recreated due to token rotation.

### Write-Only / Placeholder Attributes

- **`admin_password`** — Set to the placeholder value `Placeholder!Ignored1` in `secrets.auto.tfvars`. This is never validated by Terraform since the password is write-only and ignored in the lifecycle rule. **Must be replaced with a real password before applying to a real cloud environment.**

### Resource Naming & State Mapping

- **Extension names in state** — The Azure API returns extension names in lowercase (`aadloginforwindows`, `microsoft.powershell.dsc`). The tfvars matches these exact names to ensure the state correctly maps extensions. The keys in the extensions map are logical (`aad_login`, `dsc`) but the `name` attribute in each extension object matches Azure's casing.

### Computed Attributes Omitted from Configuration

The following attributes are computed by Azure and **not** explicitly set in the configuration:
- `virtual_machine_id` — assigned by Azure after VM creation
- `private_ips`, `public_ips` — assigned via network interface configuration (NIC is pre-existing)
- `power_state` — managed by Azure resource lifecycle (not modeled as a `var`)
- `provisioning_state` — read-only status field
- Extension `instance_view` — read-only status from API

### External Dependencies (Not Managed)

- **Network Interface** (`azurerm_network_interface`) — Pre-existing; referenced by ID in `network_interface_ids` but not managed by this configuration
- **Managed Disk (OS)** — Created implicitly by Azure when the VM is created from image (`os_disk_create_option = "FromImage"`); not explicitly managed via `azurerm_managed_disk` resource
- **Boot Diagnostics Storage Account** — If a custom storage account were provided, it would not be managed; currently uses Azure-managed storage (`boot_diagnostics_storage_uri = null`)

### Additional Capabilities Block

The `additional_capabilities` block explicitly sets `ultra_ssd_enabled = false` and `hibernation_enabled = false`. These are provider defaults but are explicitly modeled to match Azure's behavior and prevent spurious drift if the provider's defaults change.

### Image Version

`image_version = "latest"` pins the image to the latest available version of Windows 10 Enterprise 22H2 (Gen2). Changing this to a specific version number (e.g., `23.0.1`) would pin deployments to that exact version.

### License Type

`license_type = "Windows_Client"` applies Azure Hybrid Benefit pricing for Windows 10 Enterprise and is required for Windows Virtual Desktop deployments.

### Patch Management

- `patch_mode = "AutomaticByOS"` — Patches are applied automatically by the Windows Update service on the guest OS
- `patch_assessment_mode = "ImageDefault"` — Assessment is delegated to the image's default settings

These settings align with Azure best practices for desktop virtualization workloads.

### No Computed Outputs

The root module exports no scalar outputs because resources are instantiated via `for_each`. Consumers of this module would access outputs via expressions like:
```hcl
module.windows_virtual_machine["arunim_host_0"].id
module.windows_virtual_machine["arunim_host_0"].private_ip_addresses
```

If a wrapper module were needed, it could re-export these outputs using `for_each`.

### Remaining Issues & Drift

**None.** The configuration is fully reconciled:
- All three resources (VM + 2 extensions) are imported into state
- All `plan` cycles report 0 changes
- No computed attributes or API quirks are causing drift
- The ignored lifecycle fields are correctly suppressed
