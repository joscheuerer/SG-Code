# Terraform/OpenTofu Documentation: Global Settings

## 1. Overview

This Terraform code manages **2 AWS Internet Gateway (IGW) resources** in the `eu-central-1` region of AWS account `470037505301`. 

The code was **generated from discovered cloud resources** and prepared for import into state via `imports.sh`. According to the handoff, the import process encountered AWS OIDC authentication failures and was not completed; however, the generated code is logically correct and will manage these resources once authentication is repaired and imports are successfully executed.

**Resources covered:**
- Internet Gateway `basic-eks` (igw-002f3e748d6007f83) → attached to VPC `vpc-046e4c08ba6dbab3d`
- Internet Gateway `vpc-rp` (igw-00e31885391627f42) → attached to VPC `vpc-07982d303cf990a25`

---

## 2. Resources

| Terraform Address | Provider | Real-World Name/ID | Purpose |
|---|---|---|---|
| `module.internet_gateway["basic_eks"].aws_internet_gateway.this` | `aws` | `igw-002f3e748d6007f83` | Internet Gateway for basic-eks VPC; enables public internet access for resources in `vpc-046e4c08ba6dbab3d` |
| `module.internet_gateway["vpc_rp"].aws_internet_gateway.this` | `aws` | `igw-00e31885391627f42` | Internet Gateway for vpc-rp; enables public internet access for resources in `vpc-07982d303cf990a25` |

---

## 3. Module Structure

### Module: `modules/internet_gateway`

**Purpose:** Encapsulates the creation and configuration of an AWS Internet Gateway.

**Files:**
- `main.tf` — Defines `aws_internet_gateway.this` resource
- `variables.tf` — Declares input variables: `vpc_id` (required), `tags` (optional)
- `outputs.tf` — Exports `id` (IGW ID) and `arn` (IGW ARN)

**Call style:** `for_each = var.internet_gateways` at root level
- Root module iterates over a `map(object({...}))` with keys: `basic_eks`, `vpc_rp`
- Each map entry supplies `vpc_id` and optional `tags`

**No external modules** — all resources are native AWS resources defined locally.

---

## 4. How Import Works

### One-Time Setup: `imports.sh`

The file `imports.sh` contains import commands that map each module-qualified resource address to its AWS resource ID:

```bash
#!/bin/sh
set -e
"$1" import -var-file environments/sg.tfvars 'module.internet_gateway["basic_eks"].aws_internet_gateway.this' 'igw-002f3e748d6007f83'
"$1" import -var-file environments/sg.tfvars 'module.internet_gateway["vpc_rp"].aws_internet_gateway.this' 'igw-00e31885391627f42'
```

**Expected execution (if OIDC authentication succeeds):**
```bash
sh imports.sh /tmp/tmp.pglDcM/terraform
```

This populates the Terraform state file (e.g., `terraform.tfstate`) with the real AWS resources, so `terraform plan` shows `0 to add, 0 to change, 0 to destroy` (clean state).

### Current Status

According to the handoff, imports **failed due to AWS OIDC authentication errors** (`InvalidIdentityToken`). The state is currently empty, meaning `terraform plan` would show `2 to add`.

### To Re-import a Single Resource

If only one resource's state is lost:

```bash
terraform import -var-file=environments/sg.tfvars 'module.internet_gateway["basic_eks"].aws_internet_gateway.this' 'igw-002f3e748d6007f83'
```

Or for the second:

```bash
terraform import -var-file=environments/sg.tfvars 'module.internet_gateway["vpc_rp"].aws_internet_gateway.this' 'igw-00e31885391627f42'
```

---

## 5. How to Use the Code

### Prerequisites

1. **Terraform/OpenTofu installed** at a known path (e.g., `/tmp/tmp.pglDcM/terraform`)
2. **AWS credentials** configured via the `StorageBackendConfig` profile (see `providers.tf`)
3. **OIDC authentication** fixed (if relying on OIDC; see Handoff § "Required Action")

### Initialize

```bash
cd /mnt/sg_workspace/user/global-settings
terraform init
```

This downloads the AWS provider and sets up the backend.

### Plan (Default Environment: `sg`)

```bash
terraform plan -var-file=environments/sg.tfvars
```

Expected output (after imports are successful):
```
No changes. Infrastructure is up-to-date.

Terraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
```

### Apply

```bash
terraform apply -var-file=environments/sg.tfvars
```

(Only needed if plan shows changes; after imports are done, no changes are expected.)

### Using a Different Environment

To target a different environment (e.g., `dev` instead of `sg`):

1. **Copy** the environment file:
   ```bash
   cp environments/sg.tfvars environments/dev.tfvars
   ```

2. **Edit** the new file to change values (e.g., different VPC IDs, tags):
   ```bash
   vi environments/dev.tfvars
   ```

3. **Plan** with the new file:
   ```bash
   terraform plan -var-file=environments/dev.tfvars
   ```

4. **Apply** if satisfied:
   ```bash
   terraform apply -var-file=environments/dev.tfvars
   ```

**Note:** No `.tf` files need to be edited; all configuration is input-driven via the `.tfvars` file.

---

## 6. Variables

### `internet_gateways`

- **Type:** `map(object({ vpc_id = string, tags = optional(map(string), {}) }))`
- **Default:** `{}`
- **Description:** Map of Internet Gateway configurations
- **Example (from `environments/sg.tfvars`):**
  ```hcl
  internet_gateways = {
    basic_eks = {
      vpc_id = "vpc-046e4c08ba6dbab3d"
      tags = {
        Name = "basic-eks"
      }
    }
    vpc_rp = {
      vpc_id = "vpc-07982d303cf990a25"
      tags = {
        Name = "vpc-rp"
      }
    }
  }
  ```

### No Sensitive Variables

This code contains **no sensitive variables** (no database passwords, API keys, etc.). All configuration is supplied via `environments/sg.tfvars` and is non-secret.

---

## 7. Infrastructure Graph

```
module.internet_gateway (for_each)
├── ["basic_eks"]
│   └── aws_internet_gateway.this
│       └── attached to: vpc-046e4c08ba6dbab3d
│           └── tags: { Name = "basic-eks" }
│
└── ["vpc_rp"]
    └── aws_internet_gateway.this
        └── attached to: vpc-07982d303cf990a25
            └── tags: { Name = "vpc-rp" }
```

**Dependency flow:**
- Each `aws_internet_gateway` depends on the `vpc_id` input variable (no computed fields depend on other resources in this stack)
- The two IGWs are independent; no resource references the other

---

## 8. Notable Decisions & Caveats

### From Handoff (`.sg/handoff.md`)

#### Import Status
- **Import not completed** due to AWS OIDC authentication failure (`InvalidIdentityToken`)
- The OIDC token audience mismatch: token has `"https://api.app.stackguardian.io"` but the IAM OIDC provider in account 470037505301 expects a different audience
- **Required action:** Fix the IAM OIDC provider trust relationship to match the SG OIDC token's audience, then re-run `sh imports.sh /tmp/tmp.pglDcM/terraform`

#### Code Correctness
- The generated code is **logically correct** and exactly models the discovered resources
- No discrepancies between the code and the real cloud state

#### Lifecycle & Computed Attributes
- **No `lifecycle { ignore_changes }`** blocks — all attributes are managed
- **No write-only attributes** requiring special handling
- All computed attributes (`id`, `arn`, `owner_id`) are handled transparently by Terraform

#### Tags & Naming
- Tags are derived from discovered resource metadata; `Name` tags match the resource names as found in AWS
- Resource naming follows the map key convention: `basic_eks` and `vpc_rp` are the logical names used in the for_each loop

#### Root Output Design
- Root `outputs.tf` is intentionally minimal (no for_each enumeration)
- This avoids the "stale-null trap" where outputs referencing for_each may unexpectedly become null during plan/apply cycles
- To read IGW IDs, use the module outputs directly: `module.internet_gateway["basic_eks"].id`, etc.

### Additional Notes

1. **Single region:** All resources are in `eu-central-1`; multi-region support would require a provider alias or separate root modules
2. **VPC references:** The code assumes the VPCs (`vpc-046e4c08ba6dbab3d`, `vpc-07982d303cf990a25`) already exist; if managing them via Terraform too, add them as separate resources/modules
3. **Destroy safety:** Detaching an IGW from a VPC via `terraform destroy` will only succeed if the VPC has no routes pointing to the IGW; Terraform does not prevent this, so manual cleanup may be needed
4. **Provider profile:** The AWS provider uses `profile = "StorageBackendConfig"`; ensure this profile exists in `~/.aws/config` and has valid credentials

---

**Generated:** 2026-08-28  
**IaC Binary:** `/tmp/tmp.pglDcM/terraform`  
**Working Directory:** `/mnt/sg_workspace/user/global-settings`  
**Region:** `eu-central-1`  
**Account ID:** `470037505301`
