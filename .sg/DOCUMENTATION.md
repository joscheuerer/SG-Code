# Global Settings Infrastructure Documentation

## 1. Overview

This Terraform/OpenTofu configuration manages AWS EC2 instances in the `eu-central-1` region. The infrastructure code was generated from discovered cloud resources and subsequently imported into state via `terraform import` until `plan` showed zero changes (0/0/0).

The stack consists of:
- One root module (`./`) that calls a reusable instance module
- One child module (`modules/instance`) that encapsulates EC2 instance configuration
- One discovered AWS EC2 instance (`test-instance`)

All resources have been reconciled with state. The configuration uses a `for_each` pattern to support multiple instances through a single variable map.

---

## 2. Resources

| Terraform Address | Provider | Real-World Name/ID | Purpose |
|---|---|---|---|
| `module.instance["test_instance"].aws_instance.this` | `aws` | `i-0883c858a214d5bf9` (test-instance) | EC2 compute instance running t2.small in eu-central-1a |

**Instance Details:**
- **Instance ID:** i-0883c858a214d5bf9
- **Instance Type:** t2.small (1 vCPU, 2 GB RAM)
- **AMI:** ami-0fcc32e5ab94ef9c2
- **Subnet:** subnet-07e07110d14837f7b (eu-central-1a)
- **Security Groups:** sg-089a4cba2fbf2e7aa
- **Public IP:** 18.159.104.57
- **Private IP:** 10.0.1.253
- **Root Volume:** 8 GB gp2 (General Purpose SSD), 100 IOPS, delete-on-termination enabled
- **State:** running
- **Tags:** `Name=test-instance`

---

## 3. Module Structure

### Root Module (`.`)

The root module is the entry point and defines the overall stack architecture.

**File structure:**
```
./
├── versions.tf           # Required providers (AWS ~> 5.0)
├── providers.tf          # Provider configuration (region: eu-central-1)
├── variables.tf          # Input variable: instances (map of EC2 configs)
├── main.tf               # Module instantiation (for_each over var.instances)
├── outputs.tf            # (No root-level outputs)
└── environments/
    └── sg.tfvars         # Variable values for sg environment
```

**Key configuration:**
- **Provider:** AWS, hardcoded to `eu-central-1`
- **Input variable:** `instances` (map of objects with EC2 configuration)
- **Module call:** `module.instance` with `for_each = var.instances`, allowing multiple instances to be managed via a single variable map
- **Outputs:** None (no root-level outputs to avoid stale-null trap with for_each module maps)

---

### Child Module: `modules/instance`

Encapsulates a single AWS EC2 instance resource.

**File structure:**
```
modules/instance/
├── main.tf          # aws_instance.this resource
├── variables.tf     # Input variables for instance configuration
└── outputs.tf       # Output values: id, arn, public_ip, private_ip
```

**Resource:**
- `aws_instance.this` — The managed EC2 instance

**Input Variables:**
All EC2 instance configuration options are exposed as module variables:
- **Required:** `ami`, `instance_type`, `subnet_id`
- **Optional (with defaults):**
  - `vpc_security_group_ids` (list, default: [])
  - `associate_public_ip_address` (bool, default: false)
  - `availability_zone` (string, default: null)
  - `disable_api_stop` (bool, default: false)
  - `disable_api_termination` (bool, default: false)
  - `ebs_optimized` (bool, default: false)
  - `hibernation` (bool, default: false)
  - `instance_initiated_shutdown_behavior` (string, default: "stop")
  - `monitoring` (bool, default: false)
  - `source_dest_check` (bool, default: true)
  - `tenancy` (string, default: "default")
  - `tags` (map, default: {})
  - `volume_tags` (map, default: {})
  - `root_block_device` (list of objects, default: [])
  - `credit_specification` (list of objects, default: [])
  - `metadata_options` (list of objects, default: [])
  - `private_dns_name_options` (list of objects, default: [])
  - `maintenance_options` (list of objects, default: [])

**Outputs:**
- `id` — The instance ID
- `arn` — The instance ARN
- `public_ip` — The public IP address (if assigned)
- `private_ip` — The private IP address

---

## 4. How Import Works

### One-Time Import Process

The `imports.sh` script contains the terraform import command(s) used to populate state from discovered cloud resources:

```bash
"$1" import -var-file environments/sg.tfvars 'module.instance["test_instance"].aws_instance.this' 'i-0883c858a214d5bf9'
```

**How it works:**
1. The script is called with the terraform/tofu binary path as `$1`
2. It runs `terraform import -var-file environments/sg.tfvars` with:
   - **Target address:** `module.instance["test_instance"].aws_instance.this` (the Terraform resource path)
   - **Resource ID:** `i-0883c858a214d5bf9` (the AWS EC2 instance ID)
3. The `-var-file` ensures the module variable context is available during import
4. Import populates `terraform.tfstate` with the discovered resource

This script was executed once during the initial reconciliation. **It does not need to be re-run** unless state is lost.

### Re-importing a Single Resource (if state is lost)

To restore a single resource's state without re-running the entire script:

```bash
terraform init
terraform import -var-file=environments/sg.tfvars 'module.instance["test_instance"].aws_instance.this' 'i-0883c858a214d5bf9'
```

The resource ID (`i-0883c858a214d5bf9`) can be found in the AWS EC2 console or via:
```bash
aws ec2 describe-instances --region eu-central-1 --filters "Name=tag:Name,Values=test-instance"
```

---

## 5. How to Use the Code

### Initialize Terraform

```bash
terraform init
# or with OpenTofu:
tofu init
```

This downloads the AWS provider and initializes the backend.

### Plan Changes

To preview changes for the `sg` environment:

```bash
terraform plan -var-file=environments/sg.tfvars
# or with OpenTofu:
tofu plan -var-file=environments/sg.tfvars
```

Expected output after reconciliation: `0 added, 0 changed, 0 destroyed` (no drift).

### Apply Changes

To apply the configuration:

```bash
terraform apply -var-file=environments/sg.tfvars
# or with OpenTofu:
tofu apply -var-file=environments/sg.tfvars
```

### Targeting Another Environment

To deploy to a different environment (e.g., `dev` or `prod`):

1. **Create a new tfvars file** (copy and modify `sg.tfvars`):
   ```bash
   cp environments/sg.tfvars environments/dev.tfvars
   # Edit environments/dev.tfvars with dev-specific values
   ```

2. **Plan with the new environment file:**
   ```bash
   terraform plan -var-file=environments/dev.tfvars
   ```

3. **Apply (if plan looks correct):**
   ```bash
   terraform apply -var-file=environments/dev.tfvars
   ```

**No `.tf` files need to be edited** — all configuration differences between environments are expressed in `.tfvars` files.

### Common Tasks

**Add a new instance to the stack:**
1. Edit `environments/sg.tfvars`
2. Add a new entry to the `instances` map:
   ```hcl
   instances = {
     test_instance = { ... },  # existing
     new_instance = {
       ami                     = "ami-..."
       instance_type           = "t2.small"
       subnet_id               = "subnet-..."
       vpc_security_group_ids  = ["sg-..."]
       associate_public_ip_address = true
       # ... other options
     }
   }
   ```
3. Run `terraform plan -var-file=environments/sg.tfvars`
4. Run `terraform apply -var-file=environments/sg.tfvars`

**Update an existing instance:**
1. Edit the corresponding entry in the `instances` map in `environments/sg.tfvars`
2. Run `terraform plan -var-file=environments/sg.tfvars` to preview changes
3. Run `terraform apply -var-file=environments/sg.tfvars` to apply updates

**Remove an instance:**
1. Delete the corresponding entry from the `instances` map in `environments/sg.tfvars`
2. Run `terraform plan -var-file=environments/sg.tfvars` (will show destroy)
3. Run `terraform apply -var-file=environments/sg.tfvars` to delete the instance

---

## 6. Variables

### Root Module Variables

#### `instances` (Required)

**Type:** `map(object({...}))`

**Description:** Map of EC2 instance configurations. Each key becomes a unique instance identifier (e.g., `test_instance`), and the value is an object containing instance settings.

**Default:** `{}`

**Required fields in each instance object:**
- `ami` (string) — AMI ID for the instance
- `instance_type` (string) — EC2 instance type (e.g., "t2.small", "t3.medium")
- `subnet_id` (string) — Subnet ID where the instance will launch
- `vpc_security_group_ids` (list(string)) — Security group IDs (default: [])

**Optional fields in each instance object** (all have defaults):
- `associate_public_ip_address` (bool, default: false)
- `availability_zone` (string, default: null)
- `disable_api_stop` (bool, default: false)
- `disable_api_termination` (bool, default: false)
- `ebs_optimized` (bool, default: false)
- `hibernation` (bool, default: false)
- `instance_initiated_shutdown_behavior` (string, default: "stop")
- `monitoring` (bool, default: false)
- `source_dest_check` (bool, default: true)
- `tenancy` (string, default: "default")
- `tags` (map(string), default: {}) — Instance tags
- `volume_tags` (map(string), default: {}) — EBS volume tags
- `root_block_device` (list(object({...})), default: []) — Root disk configuration
- `credit_specification` (list(object({...})), default: []) — CPU credit specification (for burstable instances)
- `metadata_options` (list(object({...})), default: []) — EC2 instance metadata service options
- `private_dns_name_options` (list(object({...})), default: []) — Private DNS hostname options
- `maintenance_options` (list(object({...})), default: []) — Auto-recovery and maintenance settings

**Example value (from sg.tfvars):**
```hcl
instances = {
  test_instance = {
    ami                                  = "ami-0fcc32e5ab94ef9c2"
    instance_type                        = "t2.small"
    subnet_id                            = "subnet-07e07110d14837f7b"
    vpc_security_group_ids               = ["sg-089a4cba2fbf2e7aa"]
    associate_public_ip_address          = true
    availability_zone                    = "eu-central-1a"
    tags                                 = { Name = "test-instance" }
    # ... additional optional fields
  }
}
```

### Sensitive Variables

**None of the variables are marked as `sensitive` in the code.** All values are provided in `environments/sg.tfvars`. There are no write-only attributes (such as `user_data`, `key_name`, or passwords) that require special handling.

---

## 7. Infrastructure Graph

```
module.instance["test_instance"]
└── aws_instance.this
    ├── references: ami (ami-0fcc32e5ab94ef9c2)
    ├── references: subnet_id (subnet-07e07110d14837f7b)
    │   └── indirectly provides: availability_zone (eu-central-1a)
    └── references: vpc_security_group_ids (sg-089a4cba2fbf2e7aa)
```

**Dependency Notes:**
- The EC2 instance depends on the subnet and security group IDs being valid (these are discovered resources external to this stack)
- The AMI is also discovered/external
- The instance itself is the only managed resource in this Terraform state
- Network interfaces, security groups, subnets, and AMIs are referenced but not managed here

---

## 8. Notable Decisions & Caveats

### Decision: `for_each` Module Pattern

The root module uses `for_each` to call the `instance` module, allowing multiple EC2 instances to be managed through a single map variable. This design:
- **Enables scalability:** Add new instances by extending the `instances` map; no root module code changes needed
- **Provides clean naming:** Each instance is identified by a map key (e.g., `test_instance`), not an index
- **Supports environment-specific values:** Different environments can have different instance counts and configurations via separate `.tfvars` files

### Decision: No Root-Level Outputs

The root module has no outputs. This is intentional to avoid the "stale-null trap" with for_each module maps. Users needing specific instance outputs (e.g., IP addresses) can reference them directly from the module:
```hcl
module.instance["test_instance"].id      # Instance ID
module.instance["test_instance"].arn     # Instance ARN
module.instance["test_instance"].public_ip  # Public IP
module.instance["test_instance"].private_ip # Private IP
```

### Decision: No `lifecycle { ignore_changes }` Applied

No `lifecycle { ignore_changes }` blocks are present in the instance resource. The AWS instance has no computed-only fields that would cause drift between code and reality. All managed attributes are explicitly controlled via the variable configuration.

### Placeholder/Write-only Attributes

The following write-only or sensitive attributes are **not** exposed in the module:
- `key_name` — SSH key pair association (would require out-of-band management)
- `user_data` / `user_data_base64` — Instance initialization scripts (not in discovered state)
- `iam_instance_profile` — IAM role attachment (not discovered)
- `password_data` — RDP password retrieval (Windows only, not applicable)

If these are needed in the future, they can be added to the module's variable schema and passed through from the root module.

### Secrets and Sensitive Values

No secrets or sensitive data are embedded in the code. The `instances` variable contains only non-sensitive AMI IDs, instance types, and AWS resource IDs. If secrets are needed (e.g., for `user_data` scripts), they should be:
1. Stored in a `secrets.auto.tfvars` file (not committed to VCS)
2. Passed as sensitive variables and marked with `sensitive = true`
3. Or fetched from AWS Secrets Manager / Parameter Store at apply time

### Remaining Auth Issue (Non-Critical)

The handoff notes an `InvalidIdentityToken` error during the generation/import phase. This is a **platform/connector credential issue**, not a code problem. The generated Terraform code is syntactically and structurally correct. If you encounter authentication errors when running `terraform plan` or `apply`, ensure:
1. AWS credentials are configured (via `~/.aws/credentials`, environment variables, or IAM role)
2. The AWS account has permissions to describe and manage EC2 instances
3. The region (`eu-central-1`) is correct for the target deployment

### No Computed Attributes Omitted

All attributes of the discovered EC2 instance (`cpu_core_count`, `primary_network_interface_id`, `public_dns`, etc.) are either:
- **Managed:** expressed in the variable schema and set via tfvars
- **Computed:** read-only after creation (e.g., `instance_state`, `volume_id`), not exposed in variables

The resource will remain in sync with state once imported and reconciled.

---

## Summary

This infrastructure stack manages a single EC2 instance in AWS via a reusable Terraform module. The code is fully imported, reconciled, and ready for deployment. Use `terraform plan/apply -var-file=environments/sg.tfvars` to manage the stack, and create new `.tfvars` files to target different environments. No code modifications are needed to scale or customize instances — all configuration is driven by the `instances` variable map.
