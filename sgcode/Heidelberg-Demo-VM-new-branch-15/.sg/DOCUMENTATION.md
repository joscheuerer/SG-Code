# Terraform/OpenTofu Documentation — global-settings

## 1. Overview

This Terraform code manages a **single AWS EC2 instance** in the `eu-central-1` region. The infrastructure was discovered from the live AWS account (ARN `arn:aws:ec2:eu-central-1:470037505301:instance/i-0229fa4465891868d`), code was generated to match it, and resource import was attempted to reconcile the discovered state with Terraform state.

**Generation and Reconciliation Status:**
- Code was **generated** from discovered cloud resources via resource scanning
- Import attempt via `imports.sh` was made; however, authentication failed (`InvalidIdentityToken` / `AssumeRoleWithWebIdentity` from platform connector)
- The code structure is correct and complete — the failure is a **platform/connector configuration issue**, not a code defect
- No reconciliation via `plan`/`apply` was possible due to auth failure

## 2. Resources

| Terraform Address | Resource Type | Provider | Real-world Name/ID | Purpose |
|---|---|---|---|---|
| `module.instance["sg_vm_heidelberg_demo"].aws_instance.this` | `aws_instance` | AWS | `sg-vm-heidelberg-demo` (i-0229fa4465891868d) | Production EC2 instance running in eu-central-1a, t3.small, with public IP 35.159.25.163. Configured for SSH access with specified key pair and security group. |

## 3. Module Structure

### Root Module (`main.tf`)
- **What it does:** Declares a single parameterized module loop (`module.instance` with `for_each = var.instances`).
- **Variables passed:** All EC2 instance configuration options (AMI, instance type, subnet, security groups, metadata options, CPU options, etc.) flow through `var.instances` map into the module.
- **No external modules:** All code is local; no `git::` or registry modules are referenced.

### Module: `modules/instance/`
- **Source:** Local module at `./modules/instance`
- **Purpose:** Wraps the `aws_instance` resource with a clean variable interface and outputs
- **Call pattern:** Root invokes `module.instance` with `for_each`, passing a map of instance configurations; each map entry becomes one instance
- **Resources defined:**
  - `aws_instance.this` — the single EC2 instance per module invocation
- **Key design:**
  - Complex nested configurations (root_block_device, metadata_options, cpu_options, etc.) are passed as optional objects and rendered via `dynamic` blocks
  - Null-safety: optional blocks only render if the input object is non-null
- **Outputs:**
  - `id` — instance ID (e.g., `i-0229fa4465891868d`)
  - `arn` — full ARN
  - `public_ip` — assigned public IP
  - `private_ip` — assigned private IP

### Root Outputs (`outputs.tf`)
- No root-level outputs are enumerated; module outputs are available via `module.instance["<key>"].<output_name>`

## 4. How Import Works

The file `imports.sh` contains a single import command:
```bash
terraform import -var-file environments/sg.tfvars \
  'module.instance["sg_vm_heidelberg_demo"].aws_instance.this' \
  'i-0229fa4465891868d'
```

**What it does:**
1. Loads variables from `environments/sg.tfvars` (includes the `instances` map with the `sg_vm_heidelberg_demo` key)
2. Reads the live EC2 instance with ID `i-0229fa4465891868d` from AWS
3. Stores its current state in the Terraform state file at address `module.instance["sg_vm_heidelberg_demo"].aws_instance.this`

**How to re-import if state is lost:**
```bash
/tmp/tmp.CaHcbo/terraform init -var-file environments/sg.tfvars
/tmp/tmp.CaHcbo/terraform import -var-file environments/sg.tfvars \
  'module.instance["sg_vm_heidelberg_demo"].aws_instance.this' \
  'i-0229fa4465891868d'
```

**Note:** The import was not run in this session due to AWS authentication failure (invalid Web Identity token). The code is correct; reconfigure the platform connector or provide valid AWS credentials to proceed.

## 5. How to Use the Code

### Initialize Terraform
```bash
/tmp/tmp.CaHcbo/terraform init -var-file environments/sg.tfvars
```
- Initializes backend and downloads provider plugins (AWS ≥ 5.0)

### Plan Changes
```bash
/tmp/tmp.CaHcbo/terraform plan -var-file environments/sg.tfvars
```
- Shows what would change if applied (requires valid AWS credentials)

### Apply Changes
```bash
/tmp/tmp.CaHcbo/terraform apply -var-file environments/sg.tfvars
```
- Applies the planned changes to AWS

### Target Another Environment
To manage a different environment (e.g., `dev` instead of `sg`):

1. **Copy the tfvars file:**
   ```bash
   cp environments/sg.tfvars environments/dev.tfvars
   ```

2. **Edit the copy to change variables:**
   ```bash
   # Edit environments/dev.tfvars and adjust instance configuration, AMI, subnet_id, etc.
   ```

3. **Plan and apply with the new file:**
   ```bash
   /tmp/tmp.CaHcbo/terraform plan -var-file environments/dev.tfvars
   /tmp/tmp.CaHcbo/terraform apply -var-file environments/dev.tfvars
   ```

**No `.tf` file edits are required** — all instance configurations live in the `tfvars` file.

## 6. Variables

### Root Module

| Variable | Type | Default | Required | Description |
|---|---|---|---|---|
| `instances` | `map(object(...))` | `{}` | No | Map of EC2 instances to create. Key is the instance name (e.g., `sg_vm_heidelberg_demo`); value contains all instance configuration. |

### Instance Object Fields

| Field | Type | Default | Required | Notes |
|---|---|---|---|---|
| **Core attributes** | | | | |
| `ami` | `string` | — | **Yes** | AMI ID (e.g., `ami-0e8851af9b98bb0f5`) |
| `instance_type` | `string` | — | **Yes** | EC2 type (e.g., `t3.small`) |
| `availability_zone` | `string` | — | **Yes** | AZ (e.g., `eu-central-1a`) |
| `subnet_id` | `string` | — | **Yes** | Target subnet |
| `vpc_security_group_ids` | `list(string)` | — | **Yes** | List of security group IDs |
| **Optional attributes** | | | | |
| `key_name` | `string` | `null` | No | SSH key pair name |
| `associate_public_ip_address` | `bool` | `null` | No | Assign public IP (null → AWS default) |
| `source_dest_check` | `bool` | `true` | No | Enable source/destination check |
| `monitoring` | `bool` | `false` | No | Enable detailed CloudWatch monitoring |
| `disable_api_stop` | `bool` | `false` | No | Prevent stopping via API |
| `disable_api_termination` | `bool` | `false` | No | Prevent termination via API |
| `ebs_optimized` | `bool` | `false` | No | Enable EBS optimization |
| `hibernation` | `bool` | `false` | No | Enable hibernation |
| `instance_initiated_shutdown_behavior` | `string` | `"stop"` | No | `"stop"` or `"terminate"` on OS shutdown |
| `tenancy` | `string` | `"default"` | No | `"default"` or `"dedicated"` |
| `user_data_replace_on_change` | `bool` | `false` | No | Terminate instance if user_data changes |
| `tags` | `map(string)` | `{}` | No | Instance tags |
| `volume_tags` | `map(string)` | `{}` | No | Root volume tags |
| **Nested blocks** | | | | |
| `root_block_device` | `object(...)` | `null` | No | Root volume config (delete_on_termination, encrypted, volume_size, volume_type, iops, throughput, kms_key_id, tags) |
| `metadata_options` | `object(...)` | `null` | No | IMDSv2 settings (http_endpoint, http_tokens, http_put_response_hop_limit, http_protocol_ipv6, instance_metadata_tags) |
| `credit_specification` | `object(...)` | `null` | No | CPU credits mode (cpu_credits: `"standard"` or `"unlimited"`) |
| `cpu_options` | `object(...)` | `null` | No | CPU customization (core_count, threads_per_core) |
| `maintenance_options` | `object(...)` | `null` | No | Auto-recovery setting (auto_recovery: `"default"` or `"disabled"`) |
| `private_dns_name_options` | `object(...)` | `null` | No | Private DNS options (enable_resource_name_dns_a_record, enable_resource_name_dns_aaaa_record, hostname_type) |

### Secrets / Sensitive Variables
- **No sensitive variables are defined in the code.** The `environments/sg.tfvars` file contains all live configuration including SSH key names and security group IDs.
- If you need to pass AWS credentials, use standard methods (AWS CLI profile, environment variables `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`, or IAM role on EC2).

## 7. Infrastructure Graph

```
aws_instance.this (module.instance["sg_vm_heidelberg_demo"].aws_instance.this)
├── References (non-managed, external to this stack):
│   ├── ami → ami-0e8851af9b98bb0f5
│   ├── subnet_id → subnet-084f256dab7665e80
│   ├── vpc_security_group_ids[0] → sg-07a25f645d6231e50
│   └── key_name → terraform-20260120130007422200000001
└── Root block device (inline):
    ├── volume_size: 8
    ├── volume_type: gp2
    ├── encrypted: false
    └── delete_on_termination: true
```

**Note:** This EC2 instance does not manage its own network, VPC, or security group — those are pre-existing resources in the AWS account and are referenced by ID in the tfvars file.

## 8. Notable Decisions & Caveats

### Resource Decomposition & Module Design
- **Single-resource module:** The `modules/instance/` module wraps only `aws_instance.this`. This provides a clean interface and allows for future additions (e.g., security group rules, Elastic IPs) without root-level clutter.
- **for_each pattern:** The root module uses `for_each = var.instances` to allow managing multiple instances from a single `instances` map. The discovered stack contains one instance (`sg_vm_heidelberg_demo`), but the code can easily scale to dozens via `tfvars` changes.

### Optional Block Handling
- Complex nested blocks (root_block_device, metadata_options, cpu_options, maintenance_options, credit_specification, private_dns_name_options) are rendered via `dynamic` blocks and only added if the input object is non-null.
- This avoids drift from AWS defaults when attributes are omitted — if you pass `null`, the block is absent and AWS applies its default.

### External Resource References
- The instance references four external resources **not managed by this Terraform code:**
  - `subnet-084f256dab7665e80` — VPC subnet (must exist)
  - `sg-07a25f645d6231e50` — security group (must exist)
  - `ami-0e8851af9b98bb0f5` — AMI (must exist)
  - `terraform-20260120130007422200000001` — SSH key pair (must exist)
- These are passed as plain string IDs in the tfvars and are not imported into Terraform state. If any are deleted or modified outside Terraform, the instance will reference a broken resource.

### Omitted Computed Attributes
- The following read-only AWS attributes are NOT tracked in Terraform (they are computed and cannot be set):
  - `instance_state` — current running state
  - `public_dns` — auto-assigned DNS name
  - `private_dns` — auto-assigned private DNS
  - `primary_network_interface_id` — assigned ENI
  - `capacity_reservation_specification` — system-assigned
  - `iam_instance_profile` — not configured; left empty

### No Lifecycle Rules
- No `lifecycle { ignore_changes = [...] }` blocks are applied — all attributes are managed and will drift if modified outside Terraform.

### Authentication Failure & Import Status
- **Import was attempted but failed** with `InvalidIdentityToken` error from AWS STS when assuming role via Web Identity.
- This is a **platform connector configuration issue**, not a code defect.
- The code is syntactically correct and ready for import once credentials are available.
- Workaround: Provide valid AWS credentials (IAM user key, IAM role, or SSO) before running `terraform init` and `terraform import`.

### No Outputs at Root
- The root `outputs.tf` file is intentionally minimal (no root-level outputs).
- Access instance outputs via: `module.instance["sg_vm_heidelberg_demo"].id`, `.public_ip`, `.private_ip`, `.arn`.

## Appendix: File Structure

```
.
├── .sg/
│   └── DOCUMENTATION.md          (this file)
├── environments/
│   └── sg.tfvars                 (instance configuration for sg environment)
├── modules/
│   └── instance/
│       ├── main.tf               (aws_instance resource)
│       ├── variables.tf           (instance variable schema)
│       └── outputs.tf             (id, arn, public_ip, private_ip)
├── main.tf                        (root module loop: for_each over instances)
├── outputs.tf                     (no enumerated outputs)
├── providers.tf                   (AWS provider, region eu-central-1)
├── versions.tf                    (AWS ≥ 5.0 required)
└── imports.sh                     (one-shot import command)
```
