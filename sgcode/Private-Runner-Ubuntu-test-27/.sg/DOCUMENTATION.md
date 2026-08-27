# Infrastructure Documentation — global-settings

## 1. Overview

This Terraform configuration manages a small set of AWS EC2 resources in the **eu-central-1** region, generated from discovered cloud resources and reconciled via `import` until the plan showed 0 additions, 0 changes, 0 deletions. The code now represents the exact current state of the infrastructure:

- **1 EC2 instance** (`taher-private-runner-ubuntu`): a t2.medium Ubuntu runner in a private subnet
- **1 standalone EBS volume** (`vol-072212cd519ee269f`): a 32 GiB gp3 volume for additional storage
- **1 EC2 key pair** (`taher-private-runner`): SSH access credential

All resources were imported from AWS into Terraform state; the configuration is now a source of truth for these resources and can be versioned and modified as needed.

---

## 2. Resources

| Terraform Address | Provider | Real-World Name/ID | Purpose |
|---|---|---|---|
| `module.instance["taher_private_runner_ubuntu"].aws_instance.this` | aws | `i-0a0ca27d00e7e74b9` | EC2 instance (t2.medium) running Ubuntu in subnet-072669658da496c4a, attached to security group sg-092a5ff991a0802bc. Configured with IMDSv2 enforcement and 32 GiB gp3 root volume. Currently stopped. |
| `module.ebs_volume["vol_072212cd519ee269f"].aws_ebs_volume.this` | aws | `vol-072212cd519ee269f` | Standalone EBS volume (32 GiB, gp3, 3000 IOPS, 125 MiB/s throughput) in eu-central-1a. Currently attached to the instance as /dev/sda1 (root). |
| `module.key_pair["taher_private_runner"].aws_key_pair.this` | aws | `taher-private-runner` (key ID: `key-07b4fecdf3b13a3b9`) | EC2 key pair for SSH access. Used by the instance. Public key is write-only; placeholder retained post-import. |

---

## 3. Module Structure

### Root Module (`/mnt/sg_workspace/user/global-settings`)
The root module orchestrates three child modules via `for_each` loops, with no bare resource declarations:

- **`module.instance`** — for_each over `var.instances` (map)
  - Calls `./modules/instance`
  - Keys: `taher_private_runner_ubuntu`
  
- **`module.ebs_volume`** — for_each over `var.ebs_volumes` (map)
  - Calls `./modules/ebs_volume`
  - Keys: `vol_072212cd519ee269f`
  
- **`module.key_pair`** — for_each over `var.key_pairs` (map)
  - Calls `./modules/key_pair`
  - Keys: `taher_private_runner`

### `modules/instance/` — EC2 Instance Module
**Source:** Local (./modules/instance)

**Resources:**
- `aws_instance.this` — manages a single EC2 instance

**Variables:**
- `ami` (required, string): AMI ID
- `instance_type` (required, string): Instance type (e.g., t2.medium)
- `key_name` (required, string): Key pair name
- `subnet_id` (required, string): Target subnet
- `vpc_security_group_ids` (required, list): Security groups
- `source_dest_check` (bool, default: true)
- `tenancy` (string, default: "default")
- `ebs_optimized` (bool, default: false)
- `metadata_options` (optional, object): IMDSv2 settings (http_endpoint, http_tokens, http_put_response_hop_limit, instance_metadata_tags)
- `root_block_device` (optional, object): Root volume config (volume_type, volume_size, delete_on_termination, encrypted)
- `tags` (optional, map of string)

**Outputs:**
- `id`: Instance ID
- `arn`: Instance ARN

**Lifecycle:**
- `ignore_changes = [user_data]`: User data is not surfaced by discovery; ignoring it prevents Terraform from detecting drift on unmanaged bootstrap scripts.

### `modules/ebs_volume/` — Standalone EBS Volume Module
**Source:** Local (./modules/ebs_volume)

**Resources:**
- `aws_ebs_volume.this` — manages a single EBS volume (not attached to a specific instance at the module level)

**Variables:**
- `availability_zone` (required, string): AZ for the volume
- `size` (required, number): Volume size in GiB
- `type` (required, string): Volume type (gp2, gp3, io1, io2, sc1, st1, standard)
- `iops` (optional, number): IOPS (for io1, io2, gp3)
- `throughput` (optional, number): Throughput in MiB/s (gp3 only)
- `encrypted` (bool, default: false)
- `multi_attach_enabled` (bool, default: false)
- `tags` (optional, map of string)

**Outputs:**
- `id`: Volume ID
- `arn`: Volume ARN

### `modules/key_pair/` — EC2 Key Pair Module
**Source:** Local (./modules/key_pair)

**Resources:**
- `aws_key_pair.this` — manages an EC2 key pair

**Variables:**
- `key_name` (required, string): Key pair name
- `public_key` (required, sensitive string): Public key material (write-only; ignored after import)
- `tags` (optional, map of string)

**Outputs:**
- `key_name`: The key pair name
- `key_pair_id`: The key pair ID

**Lifecycle:**
- `ignore_changes = [public_key]`: AWS does not return the public key after creation; it is write-only. The `public_key` attribute is ignored after initial import to prevent spurious diffs from a placeholder value.

---

## 4. How Import Works

The infrastructure was imported from AWS into Terraform state via the `imports.sh` script. This script must be run once after `terraform init` to populate the state file with discovered resources.

### Import Commands (from `imports.sh`)

```bash
terraform import -var-file environments/sg.tfvars 'module.instance["taher_private_runner_ubuntu"].aws_instance.this' 'i-0a0ca27d00e7e74b9'
terraform import -var-file environments/sg.tfvars 'module.ebs_volume["vol_072212cd519ee269f"].aws_ebs_volume.this' 'vol-072212cd519ee269f'
terraform import -var-file environments/sg.tfvars 'module.key_pair["taher_private_runner"].aws_key_pair.this' 'taher-private-runner'
```

### How to Re-import a Single Resource

If state is lost or a resource needs to be re-imported:

```bash
terraform import -var-file environments/sg.tfvars 'module.instance["taher_private_runner_ubuntu"].aws_instance.this' 'i-0a0ca27d00e7e74b9'
# or
terraform import -var-file environments/sg.tfvars 'module.ebs_volume["vol_072212cd519ee269f"].aws_ebs_volume.this' 'vol-072212cd519ee269f'
# or
terraform import -var-file environments/sg.tfvars 'module.key_pair["taher_private_runner"].aws_key_pair.this' 'taher-private-runner'
```

**Note:** Key pair import uses the key name (`taher-private-runner`), not the internal key-pair ID (`key-07b4fecdf3b13a3b9`), which the AWS provider does not accept as an import target.

---

## 5. How to Use the Code

### Prerequisites
- Terraform or OpenTofu installed
- AWS credentials configured (e.g., via `~/.aws/credentials` or environment variables)
- Working directory: `/mnt/sg_workspace/user/global-settings`

### Initialize Terraform

```bash
cd /mnt/sg_workspace/user/global-settings
terraform init
```

This will initialize the Terraform working directory and download the AWS provider.

### Plan Changes

```bash
terraform plan -var-file=environments/sg.tfvars
```

This produces a plan showing what would be added, changed, or destroyed.

### Apply Changes

```bash
terraform apply -var-file=environments/sg.tfvars
```

This applies the planned changes to AWS. Terraform will prompt for confirmation before proceeding.

### Target Another Environment (e.g., Dev → Prod)

1. Copy `environments/sg.tfvars` to a new file for the target environment (e.g., `environments/prod.tfvars`):
   ```bash
   cp environments/sg.tfvars environments/prod.tfvars
   ```

2. Edit the new file to change variable values (e.g., instance types, AMI IDs, security groups, tags):
   ```bash
   vim environments/prod.tfvars
   ```

3. Plan with the new environment file:
   ```bash
   terraform plan -var-file=environments/prod.tfvars
   ```

4. Apply with the new environment file:
   ```bash
   terraform apply -var-file=environments/prod.tfvars
   ```

**Important:** Do not modify any `.tf` files themselves. All configuration is environment-specific and lives in `*.tfvars` files.

---

## 6. Variables

### Core Input Variables

#### `var.instances`
- **Type:** `map(object({...}))`
- **Default:** `{}`
- **Description:** Map of EC2 instance configurations keyed by instance name (snake_case).
- **Required fields per instance:**
  - `ami`: AMI ID
  - `instance_type`: Instance type (e.g., "t2.medium")
  - `key_name`: Name of the key pair
  - `subnet_id`: Subnet ID
  - `vpc_security_group_ids`: List of security group IDs
- **Optional fields per instance:**
  - `source_dest_check`: Boolean (default: true)
  - `tenancy`: String (default: "default")
  - `ebs_optimized`: Boolean (default: false)
  - `metadata_options`: Object with `http_endpoint`, `http_tokens`, `http_put_response_hop_limit`, `instance_metadata_tags`
  - `root_block_device`: Object with `volume_type`, `volume_size`, `delete_on_termination`, `encrypted`
  - `tags`: Map of tags

**Current value (from `environments/sg.tfvars`):**
```hcl
instances = {
  taher_private_runner_ubuntu = {
    ami                    = "ami-03250b0e01c28d196"
    instance_type          = "t2.medium"
    key_name               = "taher-private-runner"
    subnet_id              = "subnet-072669658da496c4a"
    vpc_security_group_ids = ["sg-092a5ff991a0802bc"]
    source_dest_check      = true
    tenancy                = "default"
    ebs_optimized          = false
    metadata_options = {
      http_endpoint               = "enabled"
      http_tokens                 = "required"
      http_put_response_hop_limit = 2
      instance_metadata_tags      = "disabled"
    }
    root_block_device = {
      volume_type           = "gp3"
      volume_size           = 32
      delete_on_termination = true
      encrypted             = false
    }
    tags = {
      Name = "taher-private-runner-ubuntu"
    }
  }
}
```

#### `var.ebs_volumes`
- **Type:** `map(object({...}))`
- **Default:** `{}`
- **Description:** Map of standalone EBS volume configurations keyed by volume ID (snake_case).
- **Required fields per volume:**
  - `availability_zone`: AZ (e.g., "eu-central-1a")
  - `size`: Size in GiB (number)
  - `type`: Volume type (e.g., "gp3")
- **Optional fields per volume:**
  - `iops`: IOPS (default: null)
  - `throughput`: Throughput in MiB/s (default: null)
  - `encrypted`: Boolean (default: false)
  - `multi_attach_enabled`: Boolean (default: false)
  - `tags`: Map of tags

**Current value (from `environments/sg.tfvars`):**
```hcl
ebs_volumes = {
  vol_072212cd519ee269f = {
    availability_zone    = "eu-central-1a"
    size                 = 32
    type                 = "gp3"
    iops                 = 3000
    throughput           = 125
    encrypted            = false
    multi_attach_enabled = false
  }
}
```

#### `var.key_pairs`
- **Type:** `map(object({...}))`
- **Default:** `{}`
- **Description:** Map of EC2 key pair configurations keyed by key pair name (snake_case). Public key is supplied via a separate variable.
- **Required fields per key pair:**
  - `key_name`: Name of the key pair
- **Optional fields per key pair:**
  - `tags`: Map of tags

**Current value (from `environments/sg.tfvars`):**
```hcl
key_pairs = {
  taher_private_runner = {
    key_name = "taher-private-runner"
  }
}
```

#### `var.key_pair_public_keys`
- **Type:** `map(string)`
- **Default:** `{}`
- **Sensitive:** `true`
- **Description:** Map of public key material keyed by key pair map key. **Write-only** — AWS does not return the public key after creation. This variable is ignored after initial creation/import (see lifecycle block in the key_pair module).
- **Required value:** Present in `secrets.auto.tfvars` (not committed to the repository).

**Important:** This variable must be supplied via `secrets.auto.tfvars` or via `-var` flag before planning or applying. The file is deliberately absent from the repository for security.

---

## 7. Infrastructure Graph

```
aws_instance.this (module.instance["taher_private_runner_ubuntu"])
├── references key_pair: "taher-private-runner"
│   └── aws_key_pair.this (module.key_pair["taher_private_runner"])
├── attached to subnet: "subnet-072669658da496c4a"
├── attached to security group: "sg-092a5ff991a0802bc"
├── uses AMI: "ami-03250b0e01c28d196"
└── root_block_device
    └── (ephemeral; defined inline in aws_instance; not a separate resource)

aws_ebs_volume.this (module.ebs_volume["vol_072212cd519ee269f"])
├── in availability_zone: "eu-central-1a"
└── (currently attached to instance i-0a0ca27d00e7e74b9 as /dev/sda1, but attachment
    is not managed by this module; instance manages its own root block device)

aws_key_pair.this (module.key_pair["taher_private_runner"])
├── used by instance: i-0a0ca27d00e7e74b9 (key_name reference)
└── (8 other instances in the account also reference this key pair, but those
    instances are not managed by this configuration)
```

---

## 8. Notable Decisions & Caveats

### Lifecycle Choices & Reasons

| Resource | Attribute | Reason |
|---|---|---|
| `modules/instance/main.tf` — `aws_instance.this` | `user_data` | User data (bootstrap scripts) is not surfaced by the cloud discovery process. Ignoring this attribute prevents Terraform from detecting drift if the user_data has been manually modified or set outside of the configuration. Changes to user_data require explicit `terraform apply` without the `-refresh-only` flag. |
| `modules/key_pair/main.tf` — `aws_key_pair.this` | `public_key` | AWS does not return the public key material after creation (it is write-only). A placeholder value (`"placeholder-not-used-after-import"`) is stored in `secrets.auto.tfvars`. Ignoring this attribute after import prevents spurious diffs when the placeholder does not match the real key material stored in AWS. If the key pair is ever destroyed and recreated, the real public key must be provided in `secrets.auto.tfvars`. |

### Write-Only / Placeholder Attributes

- **`aws_key_pair.public_key`** — This attribute is sensitive and write-only. After the initial `import`, AWS never returns the public key via the API. A placeholder string (`"placeholder-not-used-after-import"`) is used in `secrets.auto.tfvars` to satisfy the module's input requirements. This placeholder is not used operationally and is ignored by the lifecycle rule.

### Sensitive Variables Routed to `secrets.auto.tfvars`

The following variable must be provided in `secrets.auto.tfvars` (a gitignored file not included in the repository):

- **`key_pair_public_keys`** (map of string, marked `sensitive = true`)
  - Currently contains: `{ taher_private_runner = "placeholder-not-used-after-import" }`
  - This should be rotated or replaced with the real public key if the key pair is ever destroyed and recreated.
  - If the file is lost, recreate it with real values before planning:
    ```hcl
    key_pair_public_keys = {
      taher_private_runner = "<real-public-key-material>"
    }
    ```

### Import Notes

- **Key pair import ID:** The key pair is imported by its name (`taher-private-runner`), not by the internal AWS key-pair ID (`key-07b4fecdf3b13a3b9`). The AWS provider for Terraform does not accept the internal ID as an import target.
- **EBS volume attachment:** The standalone EBS volume (`vol-072212cd519ee269f`) is currently attached to the instance as the root device (`/dev/sda1`). The attachment is managed by the instance's `root_block_device` block, not by a separate `aws_volume_attachment` resource. This configuration follows AWS best practice for root volumes.
- **Other key pair users:** The `taher-private-runner` key pair is used by 8 other EC2 instances in the account (IDs: i-000e597ea8aa8260b, i-01494deda99ac7624, i-0334fc9f1f177c10f, i-0775dae81cafeecfd, i-0c75a95227d45cb24, i-0dcc0f3494bc988ff, i-0f26efea533bf4a2e, i-0f3604b47dcf7b748), but these instances are **not managed by this configuration**. Changes to the key pair via this configuration will affect those instances as well.

### Discovered but Unmanaged Resources

- **EBS volume** (`vol-072212cd519ee269f`): Marked as "unmanaged" in the discovery metadata because it was created independently of any IaC source, but it **is** managed by this configuration after import (state_backend is now "terraform").
- **Key pair** (`taher-private-runner`): Marked as "unmanaged" in the discovery metadata because it was created independently of any IaC source, but it **is** managed by this configuration after import.

### Remaining Drift & Misconfigurations

The reconciliation result was **"No changes"** — the Terraform state matches the infrastructure as discovered. No drift remains. However, the original discovery process flagged 8 misconfigurations on the instance (not visible in the configuration but noted in the discovery JSON); these may represent security or compliance concerns (e.g., missing EBS encryption, unencrypted root volume, metadata service settings, etc.). Review the instance configuration in AWS if additional hardening is needed.

### Absence of a `terraform` Block Backend Configuration

The code does not include a `terraform { backend = ... }` block. State is stored locally in `terraform.tfstate` by default. For team/production use, configure a remote backend (e.g., S3, Terraform Cloud) by adding a `terraform` block or by using the `-backend-config` flag during `init`.

