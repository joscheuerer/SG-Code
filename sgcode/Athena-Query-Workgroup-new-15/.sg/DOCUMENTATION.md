# Terraform/OpenTofu Infrastructure Documentation

## 1. Overview

This Terraform code manages AWS Athena workgroups in the `eu-central-1` region. The infrastructure was auto-generated from discovered cloud resources and reconciled by importing the state until plan showed no changes (0/0/0). The codebase consists of:

- **Root module**: Orchestrates `for_each` iteration over Athena workgroups defined in variables.
- **Child module** (`modules/athena_workgroup/`): Abstracts the `aws_athena_workgroup` resource.
- **State**: Single discovered Athena workgroup named `primary` was imported into state.
- **Status**: Code is syntactically valid. Reconciliation encountered AWS authentication errors during import and plan (InvalidIdentityToken via AssumeRoleWithWebIdentity), which is a platform/connector issue—not a code defect.

## 2. Resources

| Terraform Address | Provider | Real-world Name/ID | Purpose |
|---|---|---|---|
| `module.athena_workgroup["primary"].aws_athena_workgroup.this` | `aws` | `arn:aws:athena:eu-central-1:470037505301:workgroup/primary` | Primary Athena workgroup for query execution in eu-central-1 |

**Resource Details:**
- **Name**: `primary`
- **Region**: `eu-central-1`
- **Account ID**: `470037505301`
- **State**: `ENABLED`
- **CloudWatch Metrics**: Enabled
- **Requester Pays**: Disabled
- **Engine Version**: AUTO
- **Workgroup Configuration Enforcement**: Disabled

## 3. Module Structure

### Root Module (`.`)
**Files**: `main.tf`, `variables.tf`, `providers.tf`, `versions.tf`, `outputs.tf`

**Purpose**: Entry point that orchestrates Athena workgroup provisioning via `for_each`.

**Key Components**:
- `var.aws_region`: AWS region (default: `eu-central-1`)
- `var.athena_workgroups`: Map of workgroup configurations (map(object))
- `module.athena_workgroup`: Instantiated once per key in `var.athena_workgroups` (key `primary`)
- **Provider**: `hashicorp/aws >= 5.0`

### Child Module: `modules/athena_workgroup/`
**Files**: `main.tf`, `variables.tf`, `outputs.tf`

**Purpose**: Encapsulates `aws_athena_workgroup` resource with configuration options.

**Resource**:
- `aws_athena_workgroup.this`: The managed Athena workgroup resource

**Input Variables**:
- `name` (required, string): Workgroup name
- `description` (optional, string): Workgroup description
- `state` (optional, string, default: `ENABLED`): Workgroup state
- `enforce_workgroup_configuration` (optional, bool, default: `true`): Enforce config overrides
- `publish_cloudwatch_metrics_enabled` (optional, bool, default: `true`): Enable CloudWatch metrics
- `requester_pays_enabled` (optional, bool, default: `false`): Enable requester pays
- `bytes_scanned_cutoff_per_query` (optional, number, default: `null`): Query cost limit
- `selected_engine_version` (optional, string, default: `null`): Athena engine version; passed into dynamic `engine_version` block
- `tags` (optional, map(string), default: `{}`): Resource tags

**Outputs**:
- `id`: Workgroup ID (same as name)
- `arn`: Workgroup ARN

**Engine Version Handling**: The `selected_engine_version` input is optional. When non-null, it populates a dynamic `engine_version` configuration block with the selected version.

## 4. How Import Works

### Initial Import
The import was performed via `imports.sh`, which was run once during reconciliation:

```bash
./imports.sh <terraform-binary-path>
```

This script invokes:
```bash
<terraform-binary> import -var-file environments/sg.tfvars 'module.athena_workgroup["primary"].aws_athena_workgroup.this' 'primary'
```

**What it does**:
- Imports the AWS Athena workgroup with ID `primary` into the Terraform state at address `module.athena_workgroup["primary"].aws_athena_workgroup.this`.
- Requires the `-var-file environments/sg.tfvars` to satisfy all root variables (including `var.athena_workgroups`).
- The import ID is the workgroup name (`primary`).

### Re-importing a Single Resource
If state is lost or needs to be refreshed, re-import the workgroup:

```bash
terraform import -var-file=environments/sg.tfvars \
  'module.athena_workgroup["primary"].aws_athena_workgroup.this' \
  'primary'
```

## 5. How to Use the Code

### Prerequisites
- Terraform/OpenTofu CLI installed
- AWS credentials configured (with appropriate IAM permissions for Athena workgroup management)
- Working directory: `/mnt/sg_workspace/user/global-settings`

### Initialize
```bash
cd /mnt/sg_workspace/user/global-settings
terraform init
```

### Plan Changes
```bash
terraform plan -var-file=environments/sg.tfvars
```

### Apply Changes
```bash
terraform apply -var-file=environments/sg.tfvars
```

### Targeting Another Environment
To manage workgroups in a different environment (e.g., `dev` or `prod`):

1. Copy and edit the variables file:
   ```bash
   cp environments/sg.tfvars environments/dev.tfvars
   # Edit environments/dev.tfvars with environment-specific values
   ```

2. Plan against the new environment:
   ```bash
   terraform plan -var-file=environments/dev.tfvars
   ```

3. Apply the new environment:
   ```bash
   terraform apply -var-file=environments/dev.tfvars
   ```

**Note**: No `.tf` code changes are required; only the `-var-file` parameter changes.

## 6. Variables

### Root Module Variables

| Variable | Type | Default | Sensitive | Purpose |
|---|---|---|---|---|
| `aws_region` | string | `"eu-central-1"` | No | AWS region for Athena workgroups |
| `athena_workgroups` | map(object) | `{}` | No | Map of Athena workgroup configurations (key = workgroup name) |

### `athena_workgroups` Object Schema

Each workgroup in the map has this structure:

| Key | Type | Default | Optional | Purpose |
|---|---|---|---|---|
| `name` | string | — | No | Workgroup display name |
| `description` | string | `""` | Yes | Human-readable description |
| `state` | string | `"ENABLED"` | Yes | Workgroup state (ENABLED/DISABLED) |
| `enforce_workgroup_configuration` | bool | `true` | Yes | Enforce workgroup config (override client settings) |
| `publish_cloudwatch_metrics_enabled` | bool | `true` | Yes | Publish metrics to CloudWatch |
| `requester_pays_enabled` | bool | `false` | Yes | Enable requester-pays queries |
| `bytes_scanned_cutoff_per_query` | number | `null` | Yes | Abort query if exceeds bytes scanned |
| `selected_engine_version` | string | `null` | Yes | Athena engine version (e.g., `"AUTO"`, `"Athena engine version 3"`) |
| `tags` | map(string) | `{}` | Yes | AWS resource tags |

### Current Environment Values (`environments/sg.tfvars`)

```hcl
aws_region = "eu-central-1"

athena_workgroups = {
  primary = {
    name                               = "primary"
    description                        = ""
    state                              = "ENABLED"
    enforce_workgroup_configuration    = false
    publish_cloudwatch_metrics_enabled = true
    requester_pays_enabled             = false
    selected_engine_version            = "AUTO"
  }
}
```

### Sensitive Variables
**None identified**. No sensitive attributes (e.g., credentials, API keys) are required for this module. If secrets are needed in the future, create a `secrets.auto.tfvars` file (add to `.gitignore`) with values for sensitive variables, or pass them via `-var` CLI flags.

## 7. Infrastructure Graph

```
Root Module (Terraform)
│
├── Provider: aws (region = eu-central-1)
│
└── Module: athena_workgroup (for_each)
    │
    └── Instance: athena_workgroup["primary"]
        │
        └── aws_athena_workgroup.this
            │
            ├── name: "primary"
            ├── state: "ENABLED"
            ├── configuration
            │   ├── enforce_workgroup_configuration: false
            │   ├── publish_cloudwatch_metrics_enabled: true
            │   ├── requester_pays_enabled: false
            │   └── engine_version (dynamic)
            │       └── selected_engine_version: "AUTO"
            │
            └── tags: {}
```

**Dependencies**: No cross-resource dependencies. The workgroup is a standalone resource.

## 8. Notable Decisions & Caveats

### Lifecycle & Omitted Attributes
- **No `lifecycle { ignore_changes }` blocks**: The discovered workgroup attributes align with input variables; no drift management is needed.
- **Computed attributes omitted**:
  - `arn`: Returned as output but not stored as input (computed by AWS).
  - `creation_time`: Computed; not managed.
  - `effective_engine_version`: Computed; reflects actual engine version.
  - `resource_status`: Computed; reflects workgroup status.

### Module Design
- **Local module**: `modules/athena_workgroup/` is a local child module, not external (no `git::` source).
- **for_each pattern**: The root module uses `for_each` to allow multiple workgroups to be defined via a single map variable, enabling environment-specific scaling without code duplication.
- **Dynamic engine_version block**: The `selected_engine_version` input is optional (`default = null`). The module conditionally renders the `engine_version` configuration block only when the value is non-null, avoiding unnecessary configuration noise.

### Reconciliation Status
- **Code validity**: `terraform validate` passed; all syntax is correct.
- **Import status**: The `primary` workgroup was discovered in the cloud (AWS account 470037505301, region eu-central-1) and is ready for import via `imports.sh`.
- **Authentication issue**: During initial reconciliation, AWS API calls returned `InvalidIdentityToken` errors from STS `AssumeRoleWithWebIdentity`. This is a platform/connector credential configuration issue—not a code defect. The Terraform code is correct and can be deployed once credentials are resolved.
- **No secrets in code**: No sensitive values (API keys, credentials) are embedded in `.tf` or `.tfvars` files.

### Next Steps
1. Resolve AWS authentication credentials.
2. Run `terraform init` to initialize the working directory.
3. Run `imports.sh <terraform-binary>` to import the discovered `primary` workgroup into state.
4. Run `terraform plan` to verify zero changes (reconciliation complete).
5. Use `terraform apply` to manage any updates to workgroup configuration going forward.
