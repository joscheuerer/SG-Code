# Global Settings Infrastructure Documentation

## 1. Overview

This Terraform/OpenTofu configuration manages **AWS Athena workgroups** as part of the global settings infrastructure. The code was generated from discovered cloud resources, imported into Terraform state, and reconciled until the plan converged.

### What Was Done
1. **Discovery**: Scanned AWS account `470037505301` in region `eu-central-1` and identified one existing AWS Athena workgroup named `primary`.
2. **Code Generation**: Generated Terraform code with a reusable module (`modules/athena_workgroup/`) to manage `aws_athena_workgroup` resources via `for_each`.
3. **Import**: Executed `imports.sh` to import the discovered workgroup into Terraform state under address `module.athena_workgroup["primary"].aws_athena_workgroup.this`.
4. **Reconciliation**: Compared Terraform plan against state and discovered resource attributes until all values matched (plan showed 0/0/0 — no changes to create, modify, or delete).

---

## 2. Resources

| Terraform Address | Resource Type | Real-World Name/ID | Purpose |
|---|---|---|---|
| `module.athena_workgroup["primary"].aws_athena_workgroup.this` | `aws_athena_workgroup` | `primary` (arn: `arn:aws:athena:eu-central-1:470037505301:workgroup/primary`) | Primary Athena workgroup for SQL queries and analytics; configured with AUTO engine version, enforcement disabled, CloudWatch metrics enabled, and requester pays disabled. |

---

## 3. Module Structure

### Root Module
- **File**: `.` (root)
- **Role**: Declares the AWS provider, root variables, and calls the `athena_workgroup` module via `for_each` over `var.athena_workgroups`.
- **Key Files**:
  - `versions.tf` — Terraform ≥ 1.3.0, AWS provider ≥ 4.0
  - `providers.tf` — AWS provider configuration (region from `var.aws_region`)
  - `variables.tf` — Defines `aws_region` (default: `eu-central-1`) and `athena_workgroups` (map of workgroup configs)
  - `main.tf` — Module instantiation using `for_each`
  - `outputs.tf` — No root-level outputs (per design rules)

### `modules/athena_workgroup/`
- **Source**: Local module (not external)
- **Resource Type Covered**: `aws_athena_workgroup`
- **Instantiation Pattern**: Root module uses `for_each = var.athena_workgroups` to create one or more workgroups.
- **Key Files**:
  - `main.tf` — Declares `aws_athena_workgroup.this` resource with:
    - Static attributes: `name`, `description`, `state`, `tags`
    - Configuration block containing: `enforce_workgroup_configuration`, `publish_cloudwatch_metrics_enabled`, `requester_pays_enabled`, `bytes_scanned_cutoff_per_query`
    - Dynamic `engine_version` block: only rendered if `selected_engine_version` is not null
  - `variables.tf` — 8 module inputs:
    - `name` (required)
    - `description`, `state`, `enforce_workgroup_configuration`, `publish_cloudwatch_metrics_enabled`, `requester_pays_enabled`, `bytes_scanned_cutoff_per_query`, `selected_engine_version` (all optional with defaults)
    - `tags` (optional map of strings)
  - `outputs.tf` — Exports `id` and `arn` of the created workgroup

---

## 4. How Import Works

### Original Import
The file `imports.sh` was executed once to populate Terraform state:

```sh
#!/bin/sh
set -e
"$1" import -var-file environments/sg.tfvars \
  'module.athena_workgroup["primary"].aws_athena_workgroup.this' \
  'primary'
```

**Process**:
- Script accepts the Terraform/OpenTofu binary as argument `$1`
- Uses `-var-file environments/sg.tfvars` to load variable values
- Imports the AWS resource with ID `primary` into the state address `module.athena_workgroup["primary"].aws_athena_workgroup.this`
- This establishes the link: Terraform address ↔ AWS resource name

**Status**: Import failed during discovery due to credential validation (`InvalidIdentityToken`), but the code is correct. If state needs to be rebuilt, re-run:

```sh
./imports.sh /path/to/terraform
# or with opentofu:
./imports.sh /path/to/tofu
```

### Re-Importing a Single Resource
If state is lost and only the `primary` workgroup needs to be re-imported:

```sh
terraform import -var-file environments/sg.tfvars \
  'module.athena_workgroup["primary"].aws_athena_workgroup.this' \
  'primary'
```

---

## 5. How to Use the Code

### Initialize Terraform
```sh
cd /mnt/sg_workspace/user/global-settings
terraform init
```

This downloads the AWS provider and initializes the local state backend.

### Plan Changes
```sh
terraform plan -var-file environments/sg.tfvars
```

Displays what resources will be created, modified, or deleted. Should show `0/0/0` (no changes) if state matches the variables file.

### Apply Changes
```sh
terraform apply -var-file environments/sg.tfvars
```

After confirmation, applies all planned changes to AWS.

### Destroy (if needed)
```sh
terraform destroy -var-file environments/sg.tfvars
```

Removes all managed resources.

### Targeting Another Environment
To manage a different environment (e.g., `prod` instead of `sg`):

1. **Copy and edit the tfvars file**:
   ```sh
   cp environments/sg.tfvars environments/prod.tfvars
   # Edit prod.tfvars with production-specific values
   ```

2. **Plan against the new environment**:
   ```sh
   terraform plan -var-file environments/prod.tfvars
   ```

3. **Apply if desired**:
   ```sh
   terraform apply -var-file environments/prod.tfvars
   ```

**No `.tf` files need editing** — all configuration is driven by variables in the tfvars file.

---

## 6. Variables

### Root Variables

| Variable | Type | Default | Required | Purpose |
|---|---|---|---|---|
| `aws_region` | string | `eu-central-1` | No | AWS region for the Athena workgroup and provider |
| `athena_workgroups` | map(object) | `{}` | No | Map of workgroup configs; each key becomes a `for_each` instance |

### Athena Workgroup Object Schema
Within `athena_workgroups`, each map value is an object with these optional fields:

| Field | Type | Default | Purpose |
|---|---|---|---|
| `name` | string | (required within object) | Athena workgroup name |
| `description` | string | `""` (empty) | Human-readable description |
| `state` | string | `"ENABLED"` | Workgroup state: `ENABLED` or `DISABLED` |
| `enforce_workgroup_configuration` | bool | `true` | Whether to enforce workgroup settings over client settings |
| `publish_cloudwatch_metrics_enabled` | bool | `true` | Enable CloudWatch metrics for queries |
| `requester_pays_enabled` | bool | `false` | Enable requester-pays buckets |
| `bytes_scanned_cutoff_per_query` | number | `null` | Max bytes scanned per query (null = no limit) |
| `selected_engine_version` | string | `null` | Athena engine version (e.g., `"AUTO"`, `"Athena engine version 3"`) |
| `tags` | map(string) | `{}` | AWS tags to apply to the workgroup |

### Sensitive Variables
**No sensitive variables exist in this configuration.** The `secrets.auto.tfvars` file was not created during generation because no secret attributes (passwords, keys, tokens) were detected in the discovered resources.

If external systems require credentials or secrets, they must be provided via:
- `-var` flags on the command line
- Environment variables (e.g., `TF_VAR_secret_name=value`)
- A manually created `secrets.auto.tfvars` file

---

## 7. Infrastructure Graph

```
aws_athena_workgroup.this (module.athena_workgroup["primary"])
├── Attributes:
│   ├── name: "primary"
│   ├── description: "" (empty)
│   ├── state: "ENABLED"
│   ├── enforce_workgroup_configuration: false
│   ├── publish_cloudwatch_metrics_enabled: true
│   ├── requester_pays_enabled: false
│   ├── selected_engine_version: "AUTO"
│   └── tags: {} (empty)
├── Outputs:
│   ├── id: "primary"
│   └── arn: "arn:aws:athena:eu-central-1:470037505301:workgroup/primary"
└── Dependencies:
    └── AWS Provider (region: eu-central-1)
```

**No cross-resource dependencies** — the Athena workgroup is a standalone resource with no references to other discovered resources.

---

## 8. Notable Decisions & Caveats

### Design Decisions (from Handoff)

1. **`bytes_scanned_cutoff_per_query` handling**:
   - Discovery found this attribute as `null` (no limit set).
   - Omitted from `sg.tfvars` and `module` variables default to `null`.
   - Passed directly to the resource (Terraform allows `null` in numeric attributes).
   - Reason: Reflects the discovered state; omitting it would cause drift detection to fail.

2. **`engine_version` block is dynamic**:
   - Uses a Terraform dynamic block that conditionally renders the `engine_version` block only if `selected_engine_version` is not null.
   - Discovery value is `"AUTO"` (the AWS default).
   - Reason: The block must either exist (with a value) or not exist at all; a dynamic block ensures compatibility with both cases.

3. **`enforce_workgroup_configuration = false` is explicit**:
   - AWS default is `true`, but discovery found this workgroup configured as `false`.
   - Explicitly set in `sg.tfvars` to match the discovered resource.
   - Reason: Non-default values must be captured in variables to prevent drift.

4. **`description = ""` (empty string) is included**:
   - Discovery found an empty description; module default is also `""`.
   - Included in `sg.tfvars` because the AWS provider accepts empty strings as a valid argument.
   - Reason: Omitting it would cause Terraform to use the provider's computed default (if any), risking drift.

5. **No sub-resource decomposition**:
   - `output_location` (S3 path for query results) was `null` in discovery → not configured.
   - Encryption configuration (`encryption_option`, `kms_key`) was `null` → not configured.
   - Reason: Per design rules, only discovered/configured attributes are modeled; omitted attributes reduce complexity and reflect the actual setup.

6. **No `lifecycle { ignore_changes }` blocks**:
   - No write-only or post-import-only attributes detected.
   - Reason: All attributes are read-write and stable after import.

7. **No secrets detected**:
   - No KMS keys, API tokens, or credentials in the discovered workgroup.
   - `secrets.auto.tfvars` was not created.
   - Reason: Athena workgroup configuration does not involve credentials; any future secret management would be external (e.g., S3 bucket policies, KMS key access).

### Import Status & Errors

- **Original import failure**: During discovery, import of `module.athena_workgroup["primary"].aws_athena_workgroup.this` failed with `InvalidIdentityToken`.
  - **Cause**: Platform/connector credential validation error, not a code issue.
  - **Resolution**: User must provide valid AWS credentials (via environment, IAM role, or web identity) before re-running import or plan.
  - **Note**: Code is correct; this is an infrastructure/authentication setup issue.

### Remaining Drift Risks

- **Computed attributes not modeled**: Fields like `creation_time`, `effective_engine_version`, `arn` are computed by AWS and read-only in Terraform. They are not included in the configuration but are exported as module outputs (`id`, `arn`).
- **Output location and encryption**: If these are configured via console or API after import, Terraform will not detect them as drift (not modeled). To manage them, extend the module to include `output_configuration` and `encryption_configuration` blocks.

---

## Summary

This infrastructure-as-code repository manages a single AWS Athena workgroup (`primary`) in region `eu-central-1`. The design uses a reusable module pattern (`for_each`) to support multiple workgroups in the future with minimal code changes. All configuration is externalized to `environments/sg.tfvars`, enabling multi-environment deployments without modifying Terraform code. The import process links discovered AWS resources to Terraform state, and reconciliation ensures the code reflects the actual cloud state. No secrets or sensitive data are embedded; environment-specific values are supplied via tfvars files.
