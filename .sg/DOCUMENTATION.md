# Azure Global Settings Infrastructure Documentation

## 1. Overview

This Terraform configuration manages Azure global settings and governance resources, specifically **Azure RBAC (Role-Based Access Control) role assignments** and **management group policy assignments**.

The infrastructure was generated from discovered Azure cloud resources and reconciled through automated import into Terraform state until the `plan` command showed zero changes (0 additions, 0 modifications, 0 deletions), indicating perfect alignment between the Terraform configuration and actual Azure resources.

**Generation and Reconciliation Process:**
- Resources were discovered from Azure through cloud scanning
- Terraform configurations and modules were automatically generated
- Resources were imported into state via `imports.sh` using the `terraform import` command
- Final reconciliation confirmed all resources are tracked and synchronized (`plan` → No changes)

## 2. Resources

The following table documents all managed and discovered resources:

| Terraform Address | Provider Type | Real-World Name / ID | Purpose | State |
|---|---|---|---|---|
| `module.role_assignment["r_08a0436e_18f0_4626_a803_168e302a52f7"].azurerm_role_assignment.this` | azurerm_role_assignment | 08a0436e-18f0-4626-a803-168e302a52f7 | Service Principal role assignment scoped to subscription a97621d8-9158-4681-81b6-38b1222afba4; assigns "Storage Blob Data Contributor" role (acdd72a7-3385-48ef-bd42-f606fba81ae7) to principal d0de9921-4e06-447c-bf63-36b63455b165 | **Managed** |
| (Not managed) — azurerm_management_group_policy_assignment | Policy ID: 30d3965d762745f496b7330d | [Preview]: Users must authenticate with multi-factor authentication to create or update resources | MFA enforcement policy for create/update operations; assigned to management group e486c990-3cab-4813-a86a-77b4c6b8f3d6; enforcement mode: DoNotEnforce | Excluded (403 AuthorizationFailed) |
| (Not managed) — azurerm_management_group_policy_assignment | Policy ID: 65ffe745b4544d1cb1251371 | [Preview]: Users must authenticate with multi-factor authentication to delete resources | MFA enforcement policy for delete operations; assigned to management group e486c990-3cab-4813-a86a-77b4c6b8f3d6; enforcement mode: DoNotEnforce | Excluded (403 AuthorizationFailed) |
| (Not managed) — azurerm_management_group_policy_assignment | Policy ID: sys.mfa-write | Microsoft Azure Multi Factor Authentication Enforcement for Resource Write Actions | MFA enforcement policy for write operations; assigned to management group e486c990-3cab-4813-a86a-77b4c6b8f3d6; enforcement mode: Default (enforced); effect: Deny | Excluded (403 AuthorizationFailed) |
| (Not managed) — azurerm_role_assignment | Role ID: 8c33f5e2-222f-4d11-86a8-9cd8e8e7d215 | 8c33f5e2-222f-4d11-86a8-9cd8e8e7d215 | Tenant-root scope role assignment (scope="/"); assigns "Reader" role to user principal 72d8b550-af37-4eae-91ac-deee645567c1 | Excluded (Provider limitation) |
| (Not managed) — azurerm_role_assignment | Role ID: 8e90d35e-48b2-453b-a6e6-c146f9bf731d | 8e90d35e-48b2-453b-a6e6-c146f9bf731d | Tenant-root scope role assignment (scope="/"); assigns "Reader" role to user principal 168ba27d-fabc-48a8-a995-77fc63cf3c81 | Excluded (Provider limitation) |

## 3. Module Structure

The configuration uses two local modules under `modules/`:

### `modules/role_assignment/`
**Purpose:** Encapsulates `azurerm_role_assignment` resource configuration for assigning Azure RBAC roles to principals (users, service principals, groups).

**Contents:**
- `main.tf` — Declares single `azurerm_role_assignment.this` resource
- `variables.tf` — Defines module inputs: `name`, `scope`, `role_definition_id`, `principal_id`
- `outputs.tf` — Exports the resource ID

**Call Site:** Root module (`main.tf`), instantiated via `for_each = var.role_assignments` (map-based iteration)

**Module Key Pattern:** Map keys are sanitized GUIDs (e.g., `r_08a0436e_18f0_4626_a803_168e302a52f7`), where the GUID portion is the actual Azure role assignment ID with underscores replacing hyphens for Terraform identifier safety.

### `modules/policy_assignment/`
**Purpose:** Encapsulates `azurerm_management_group_policy_assignment` resource configuration for assigning Azure policies to management groups.

**Contents:**
- `main.tf` — Declares single `azurerm_management_group_policy_assignment.this` resource; uses conditional logic to convert empty strings to `null` (lines 3, 7, 8)
- `variables.tf` — Defines module inputs: `name`, `display_name` (optional, default ""), `policy_definition_id`, `management_group_id`, `enforce` (optional, default true), `parameters` (optional, default ""), `not_scopes` (optional, default [])
- `outputs.tf` — Exports the resource ID

**Call Site:** Root module (`main.tf`), instantiated via `for_each = var.policy_assignments` (map-based iteration)

**Status:** Currently disabled in `environments/sg.tfvars` (`policy_assignments = {}`); module remains in place for future activation once platform credential permissions are restored.

## 4. How Import Works

**Import File:** `imports.sh` is a shell script that records the `terraform import` commands necessary to populate state for each resource discovered in Azure.

**Import Mechanism:**
1. Each resource discovered in Azure has a corresponding cloud-native ID (e.g., `/subscriptions/.../roleAssignments/...`)
2. The `imports.sh` script maps Terraform module-qualified addresses to these cloud IDs
3. Running `imports.sh /path/to/terraform` executes all active import commands
4. The `terraform import` command fetches the live resource from Azure and writes it into local state
5. After import, `terraform plan` verifies that the resource definition in `.tf` files matches the state (if changes shown, configuration needs refinement)

**Example Import Command (Active):**
```bash
terraform import -var-file environments/sg.tfvars \
  'module.role_assignment["r_08a0436e_18f0_4626_a803_168e302a52f7"].azurerm_role_assignment.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/providers/Microsoft.Authorization/roleAssignments/08a0436e-18f0-4626-a803-168e302a52f7'
```

**Re-importing a Single Resource (if state lost):**
```bash
terraform import -var-file environments/sg.tfvars \
  'module.role_assignment["r_08a0436e_18f0_4626_a803_168e302a52f7"].azurerm_role_assignment.this' \
  '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/providers/Microsoft.Authorization/roleAssignments/08a0436e-18f0-4626-a803-168e302a52f7'
```

**Excluded/Commented-Out Imports:**
- **3 policy assignment imports** (lines 7–10 in `imports.sh`) fail with `403 AuthorizationFailed` — the platform-managed credential lacks `Microsoft.Authorization/policyAssignments/read` at management-group scope. This is a platform/connector permission issue; environment-level corrections needed upstream, not a code issue.
- **2 tenant-root role assignment imports** (lines 18–20 in `imports.sh`) fail because `azurerm` provider v3.117.1 cannot parse scope `"/"` (tenant root / Azure AD directory scope). The provider's resource-ID parser requires subscription, resource-group, or management-group scope segments; tenant-root assignments are a known limitation.

**Import Notes:**
- Imports are executed once to populate initial state; they do not need to be re-run unless state is destroyed or a resource is removed from state.
- The `-var-file environments/sg.tfvars` flag is required during import to supply the `role_assignments` and `policy_assignments` maps.

## 5. How to Use the Code

### Initialize the Terraform Working Directory
```bash
cd /mnt/sg_workspace/user/global-settings
terraform init
```

This downloads the Azure provider and initializes the backend (default: local state in `.terraform/`).

### Plan Changes
```bash
terraform plan -var-file=environments/sg.tfvars
```

This shows what resources will be created, modified, or destroyed when the configuration is applied.

**Expected Output (Current State):**
```
No changes. Your infrastructure matches the configuration.
```

### Apply Changes
```bash
terraform apply -var-file=environments/sg.tfvars
```

This executes the plan and updates Azure resources. With the current state, no changes will be applied.

### Targeting Another Environment
To manage a different environment (e.g., prod instead of sg):

1. **Copy the tfvars file:**
   ```bash
   cp environments/sg.tfvars environments/prod.tfvars
   ```

2. **Edit the new file with prod-specific values:**
   ```bash
   # Edit environments/prod.tfvars
   # Change role_assignment keys, scope, role_definition_id, principal_id values as needed
   # Change policy_assignment keys, management_group_id, policy_definition_id values as needed
   ```

3. **Plan with the new tfvars:**
   ```bash
   terraform plan -var-file=environments/prod.tfvars
   ```

4. **Apply to prod:**
   ```bash
   terraform apply -var-file=environments/prod.tfvars
   ```

**Important:** No `.tf` files need to be edited to target a different environment — all infrastructure is defined declaratively in the tfvars file.

## 6. Variables

### Root Module Variables

#### `role_assignments` (type: `map(object({...}))`)
**Description:** Map of Azure role assignments to create.

**Type Signature:**
```hcl
map(object({
  name               = string       # Name/ID of the role assignment
  scope              = string       # Azure scope: /subscriptions/..., /resourceGroups/..., /managementGroups/..., or / (tenant root, not supported by provider)
  role_definition_id = string       # Full path to role definition, e.g., /subscriptions/.../roleDefinitions/...
  principal_id       = string       # Object ID of the principal (user, service principal, or group)
}))
```

**Default:** `{}`

**Current Value (from environments/sg.tfvars):**
```hcl
role_assignments = {
  "r_08a0436e_18f0_4626_a803_168e302a52f7" = {
    name               = "08a0436e-18f0-4626-a803-168e302a52f7"
    scope              = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4"
    role_definition_id = "/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7"
    principal_id       = "d0de9921-4e06-447c-bf63-36b63455b165"
  }
}
```

**Purpose:** Controls which role assignments are created and maintained in Azure.

#### `policy_assignments` (type: `map(object({...}))`)
**Description:** Map of Azure management group policy assignments to create.

**Type Signature:**
```hcl
map(object({
  name                 = string                  # Name of the policy assignment
  display_name         = optional(string, "")    # Human-readable display name (omit for empty)
  policy_definition_id = string                  # Full path to policy definition
  management_group_id  = string                  # Target management group resource ID or name
  enforce              = optional(bool, true)    # Whether to enforce the policy (true) or audit only (false)
  parameters           = optional(string, "")    # JSON string of policy parameters (omit for none)
  not_scopes           = optional(list(string), [])  # List of scopes to exclude from the policy (omit for none)
}))
```

**Default:** `{}`

**Current Value (from environments/sg.tfvars):**
```hcl
policy_assignments = {}
```

**Purpose:** Controls which policies are assigned to management groups. Currently empty because the platform credential lacks read permissions; module code is retained for future activation.

### No Sensitive Variables
No credential-like values (API keys, secrets, passwords, tokens) were present in the discovered resources. No `secrets.auto.tfvars` file was generated. If future resources require write-only or sensitive attributes, create `secrets.auto.tfvars` in the root module directory and populate it with the sensitive values before running `plan` or `apply`.

## 7. Infrastructure Graph

```
module.role_assignment["r_08a0436e_18f0_4626_a803_168e302a52f7"]
└── azurerm_role_assignment.this
    ├── scope: /subscriptions/a97621d8-9158-4681-81b6-38b1222afba4
    ├── role_definition_id: /subscriptions/.../roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7
    └── principal_id: d0de9921-4e06-447c-bf63-36b63455b165 (ServicePrincipal)

module.policy_assignment (for_each disabled; 0 instances)
└── azurerm_management_group_policy_assignment.this (not instantiated)
```

**Notes:**
- No explicit inter-resource dependencies exist; each role assignment and policy assignment is independent.
- The role assignment has no references to other managed resources; it depends on pre-existing Azure objects (role definition, principal) that are not managed by this configuration.
- Policy assignments (currently empty) would similarly depend on pre-existing policy definitions.

## 8. Notable Decisions & Caveats

### Excluded Resources and Reasons (from `.sg/handoff.md`)

#### Policy Assignments (3 resources: `30d3965d762745f496b7330d`, `65ffe745b4544d1cb1251371`, `sys.mfa-write`)

**Reason:** Import fails with `403 AuthorizationFailed` — the platform-managed credential (used by the cloud discovery/import service) lacks the `Microsoft.Authorization/policyAssignments/read` permission at the management-group scope (`/providers/Microsoft.Management/managementGroups/e486c990-3cab-4813-a86a-77b4c6b8f3d6`).

**Status:** This is a **platform/connector permission issue**, not a code or authentication problem. The Azure credential is managed by the cloud connector; environment-level corrections are required upstream.

**Action:** Do not attempt to fix by modifying credentials or state. Wait for platform permission updates. Once access is granted:
1. Uncomment the corresponding import commands in `imports.sh` (lines 7–10)
2. Add entries to `environments/sg.tfvars` (see commented-out lines in `imports.sh`)
3. Re-run the import script
4. Re-run `terraform plan` to verify reconciliation

**Module Integrity:** The `modules/policy_assignment/` module and its variable declarations are fully implemented and functional. Code is retained in case permissions are restored.

#### Tenant-Root Role Assignments (2 resources: `8c33f5e2-222f-4d11-86a8-9cd8e8e7d215`, `8e90d35e-48b2-453b-a6e6-c146f9bf731d`)

**Reason:** Import fails with resource-ID parsing errors because `azurerm` provider v3.117.1 cannot handle scope `"/"` (Azure AD directory root / tenant root) for `azurerm_role_assignment`. The provider's internal parser requires subscription, resource-group, or management-group scope segments; scope `"/"` lacks these required segments.

**Status:** This is a **genuine provider limitation**, not an auth or code issue. Azure does support tenant-root role assignments (directory-level RBAC), but the Terraform provider does not.

**Action:** No workaround available within this configuration. Contact HashiCorp or use the Azure CLI/PowerShell to manage these assignments outside Terraform, or upgrade to a future provider version if support is added.

**Scope Details:**
- Resource `8c33f5e2-222f-4d11-86a8-9cd8e8e7d215`: User principal `72d8b550-af37-4eae-91ac-deee645567c1`, Reader role
- Resource `8e90d35e-48b2-453b-a6e6-c146f9bf731d`: User principal `168ba27d-fabc-48a8-a995-77fc63cf3c81`, Reader role

### Conditional Null Conversion in `modules/policy_assignment/main.tf`

The policy assignment module applies a deliberate transformation on optional string inputs (lines 3, 7, 8 in `modules/policy_assignment/main.tf`):
```hcl
display_name = var.display_name != "" ? var.display_name : null
parameters   = var.parameters != "" ? var.parameters : null
not_scopes   = length(var.not_scopes) > 0 ? var.not_scopes : null
```

**Reason:** Azure's API schema for management group policy assignments does not accept empty strings for optional fields; it requires `null` to indicate "omit this field." Terraform variables default to empty strings for convenience; this transformation ensures they are converted to `null` before being sent to Azure, preventing API validation errors.

### No Write-Only Attributes

No resource in scope has computed-only or write-only attributes requiring placeholder values or secrets. All resource properties can be fully specified from discovered state without synthetic inputs.

### No Lifecycle Ignore Directives

No resources require `lifecycle { ignore_changes = [...] }` blocks. The configuration is designed to track all attributes that Azure manages.

### Reconciliation Status

**Final State:** Plan shows `No changes. Your infrastructure matches the configuration.`

This confirms:
- Terraform state is populated (via imports)
- State exactly mirrors the current Azure resources
- No drift exists
- No configuration edits are needed for existing resources
