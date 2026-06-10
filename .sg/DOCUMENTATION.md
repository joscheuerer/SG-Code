# Infrastructure Documentation

## 1. Overview

This Terraform code manages the complete network infrastructure for the **approvalv2-dev2** project in AWS region **eu-central-1**. The infrastructure was discovered from existing AWS resources and reconciled until Terraform `plan` showed **0 changes to add, 0 changes to modify, 0 to destroy** — indicating perfect alignment between code and cloud state.

The stack includes:
- 1 VPC with configurable CIDR block (`10.20.0.0/16`)
- 5 subnets (2 private, 3 public) across 3 availability zones
- 1 Internet Gateway for public ingress/egress
- 3 route tables (1 public, 1 private, 1 default/main)
- 2 security groups (1 custom for web access, 1 default VPC SG)
- 1 default Network ACL managing inbound/outbound rules
- 1 EC2 key pair for SSH access

All resources were imported into Terraform state via the `imports.sh` script and are now fully managed by code.

---

## 2. Resources

| Terraform Address | Provider | AWS Resource ID | Real-World Name | Purpose |
|---|---|---|---|---|
| `module.vpc.aws_vpc.this` | `aws` | `vpc-07ab137e2cc49c068` | `approvalv2-dev2-vpc` | Virtual Private Cloud for the project; CIDR `10.20.0.0/16` |
| `module.subnet["approvalv2_dev2_publicsubnet1"].aws_subnet.this` | `aws` | `subnet-047686cbdc216e5a1` | `approvalv2-dev2-PublicSubnet1` | Public subnet in AZ `eu-central-1a`; CIDR `10.20.10.0/24` |
| `module.subnet["approvalv2_dev2_publicsubnet2"].aws_subnet.this` | `aws` | `subnet-07971bba1b7a42270` | `approvalv2-dev2-PublicSubnet2` | Public subnet in AZ `eu-central-1b`; CIDR `10.20.20.0/24` |
| `module.subnet["approvalv2_dev2_publicsubnet3"].aws_subnet.this` | `aws` | `subnet-0b2bfeab9b9600478` | `approvalv2-dev2-PublicSubnet3` | Public subnet in AZ `eu-central-1c`; CIDR `10.20.25.0/24` |
| `module.subnet["approvalv2_dev2_privatesubnet1"].aws_subnet.this` | `aws` | `subnet-03e7a88db06b8263a` | `approvalv2-dev2-PrivateSubnet1` | Private subnet in AZ `eu-central-1a`; CIDR `10.20.30.0/24` |
| `module.subnet["approvalv2_dev2_privatesubnet2"].aws_subnet.this` | `aws` | `subnet-0ac80964ef0acb99c` | `approvalv2-dev2-PrivateSubnet2` | Private subnet in AZ `eu-central-1b`; CIDR `10.20.40.0/24` |
| `module.internet_gateway.aws_internet_gateway.this` | `aws` | `igw-04417c76d78155e2e` | `approvalv2-dev2-IGW` | Internet Gateway attached to VPC; enables public internet connectivity |
| `module.route_table["approvalv2_dev2_publicrt"].aws_route_table.this` | `aws` | `rtb-08004bb274b987779` | `approvalv2-dev2-PublicRT` | Public route table; routes `0.0.0.0/0` to IGW; associated with 2 public subnets |
| `module.route_table["approvalv2_dev2_privatert"].aws_route_table.this` | `aws` | `rtb-0f7772eb68094bb1e` | `approvalv2-dev2-PrivateRT` | Private route table (no routes to IGW); associated with 2 private subnets |
| `module.route_table["aws_route_table_2"].aws_route_table.this` | `aws` | `rtb-0a8623f5c98b5f651` | (default main RT) | VPC's main/default route table; local routes only |
| `module.security_group["approvalv2_dev2_sc1"].aws_security_group.this` | `aws` | `sg-016209b903a312283` | `approvalv2-dev2-SC1` | Custom SG; allows SSH (22), HTTP (80), HTTPS (443) from `0.0.0.0/0`; all egress allowed |
| `module.security_group["default"].aws_security_group.this` | `aws` | `sg-08ddee24b0704317a` | `default` | VPC's default security group; self-referencing ingress; all egress to `0.0.0.0/0` |
| `module.network_acl["approvalv2_dev2_nacl"].aws_default_network_acl.this` | `aws` | `acl-002a010e6f61e9ae6` | (VPC default NACL) | Default NACL for VPC; allow-all rules; manages all 5 subnets |
| `module.key_pair["ansible_instance_key"].aws_key_pair.this` | `aws` | `ansible-instance-key` | `ansible-instance-key` | EC2 key pair for SSH access; public_key is placeholder (write-only) |

---

## 3. Module Structure

### Root Configuration (`/`)

**Files:**
- `main.tf` — Root module declarations for 7 child modules
- `variables.tf` — Input variables for VPC, subnets, IGW, route tables, security groups, NACLs, and key pairs
- `versions.tf` — Provider requirements (AWS)
- `providers.tf` — AWS provider configuration (region: `eu-central-1`)
- `outputs.tf` — Empty (no root-level outputs; resources are fully contained in modules)

**Call pattern:**
- 1 singleton module: `vpc`, `internet_gateway`
- 6 `for_each` modules: `subnet` (5 instances), `route_table` (3 instances), `security_group` (2 instances), `network_acl` (1 instance), `key_pair` (1 instance)

---

### Module: `modules/vpc`

**Purpose:** Create and configure the VPC.

**Files:**
- `main.tf` — Single `aws_vpc` resource
- `variables.tf` — Inputs: `cidr_block` (string), `instance_tenancy` (optional string, default "default"), `tags` (optional map)
- `outputs.tf` — Output: `vpc_id`

**Resources managed:**
- `aws_vpc.this` — The VPC itself

**Input example:**
```hcl
vpc = {
  cidr_block       = "10.20.0.0/16"
  instance_tenancy = "default"
  tags = {
    Project    = "approvalv2"
    Enviroment = "dev2"
    Name       = "approvalv2-dev2-vpc"
  }
}
```

---

### Module: `modules/subnet`

**Purpose:** Create subnets within the VPC. Called 5 times via `for_each` from root.

**Files:**
- `main.tf` — Single `aws_subnet` resource
- `variables.tf` — Inputs: `vpc_id` (string), `cidr_block` (string), `availability_zone` (string), `map_public_ip_on_launch` (optional bool), `tags` (optional map)
- `outputs.tf` — Output: `subnet_id`

**Resources managed:**
- `aws_subnet.this` — Each subnet

**Call from root:**
```hcl
module "subnet" {
  source   = "./modules/subnet"
  for_each = var.subnets

  vpc_id                  = module.vpc.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  tags                    = each.value.tags
}
```

**Instances (from tfvars):**
- `approvalv2_dev2_publicsubnet1`, `approvalv2_dev2_publicsubnet2`, `approvalv2_dev2_publicsubnet3` — Public subnets
- `approvalv2_dev2_privatesubnet1`, `approvalv2_dev2_privatesubnet2` — Private subnets

---

### Module: `modules/internet_gateway`

**Purpose:** Create and attach an Internet Gateway to the VPC.

**Files:**
- `main.tf` — Single `aws_internet_gateway` resource
- `variables.tf` — Inputs: `vpc_id` (string), `tags` (optional map)
- `outputs.tf` — Output: `internet_gateway_id`

**Resources managed:**
- `aws_internet_gateway.this` — The IGW

**Call from root:**
```hcl
module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc.vpc_id
  tags   = var.internet_gateway.tags
}
```

---

### Module: `modules/route_table`

**Purpose:** Create route tables and configure routes. Called 3 times via `for_each` from root.

**Files:**
- `main.tf` — Single `aws_route_table` resource with dynamic routes
- `variables.tf` — Inputs: `vpc_id` (string), `routes` (optional list of objects with `cidr_block` and `use_igw`), `internet_gateway_id` (string), `tags` (optional map)
- `outputs.tf` — Output: `route_table_id`

**Resources managed:**
- `aws_route_table.this` — Each route table

**Route logic:**
- Dynamic block iterates over `var.routes` and creates routes where `use_igw = true`
- For each matching route, a route is added with `cidr_block` → `internet_gateway_id`

**Instances (from tfvars):**
- `approvalv2_dev2_publicrt` — Has 1 route: `0.0.0.0/0` to IGW (use_igw: true)
- `approvalv2_dev2_privatert` — Has 0 routes (private subnet, no IGW)
- `aws_route_table_2` — Has 0 routes (main/default route table, local routes auto-added)

---

### Module: `modules/security_group`

**Purpose:** Create security groups with ingress/egress rules. Called 2 times via `for_each` from root.

**Files:**
- `main.tf` — Single `aws_security_group` resource with dynamic ingress/egress blocks
- `variables.tf` — Inputs: `name` (string), `description` (string), `vpc_id` (string), `ingress` (optional list), `egress` (optional list), `tags` (optional map)
- `outputs.tf` — Output: `security_group_id`

**Resources managed:**
- `aws_security_group.this` — Each security group

**Rule structure (ingress/egress):**
```hcl
{
  from_port   = number
  to_port     = number
  protocol    = string
  cidr_blocks = optional(list(string), [])
  description = optional(string, "")
  self        = optional(bool, false)
}
```

**Instances (from tfvars):**
- `approvalv2_dev2_sc1` — Custom SG with SSH (22), HTTP (80), HTTPS (443) from anywhere; all egress
- `default` — VPC's default SG; self-referencing ingress; all egress to `0.0.0.0/0`

---

### Module: `modules/network_acl`

**Purpose:** Manage the VPC's default Network ACL. Called 1 time via `for_each` from root.

**Files:**
- `main.tf` — Single `aws_default_network_acl` resource with dynamic ingress/egress blocks
- `variables.tf` — Inputs: `default_network_acl_id` (string), `subnet_ids` (optional list), `ingress` (optional list), `egress` (optional list), `tags` (optional map)
- `outputs.tf` — Output: `network_acl_id`

**Resources managed:**
- `aws_default_network_acl.this` — The VPC's default NACL (modified in-place, not replaced)

**Rule structure (ingress/egress):**
```hcl
{
  rule_no    = number
  action     = string
  protocol   = string
  cidr_block = string
  from_port  = optional(number, 0)
  to_port    = optional(number, 0)
}
```

**Instance (from tfvars):**
- `approvalv2_dev2_nacl` — Manages ACL `acl-002a010e6f61e9ae6`
  - Ingress rule 100: Allow all protocols from `0.0.0.0/0`
  - Egress rule 100: Allow all protocols to `0.0.0.0/0`
  - Explicitly manages all 5 subnets via `subnet_keys` → mapped to `subnet_ids` in root

**Lifecycle note:** AWS default-deny rule (rule_no=32767) is omitted from code — it's outside valid Terraform range (1–32766) and managed implicitly by AWS.

---

### Module: `modules/key_pair`

**Purpose:** Create EC2 key pairs. Called 1 time via `for_each` from root.

**Files:**
- `main.tf` — Single `aws_key_pair` resource with `lifecycle { ignore_changes = [public_key] }`
- `variables.tf` — Inputs: `key_name` (string), `public_key` (optional string), `tags` (optional map)
- `outputs.tf` — Output: `key_pair_id`

**Resources managed:**
- `aws_key_pair.this` — Each key pair

**Lifecycle rule:**
- `ignore_changes = [public_key]` — The public_key is write-only; AWS API never returns it. To prevent drift, this attribute is excluded from Terraform's change detection.

**Instance (from tfvars):**
- `ansible_instance_key` — Key name `ansible-instance-key`; public_key set to `"placeholder"` (real key not available from discovery)

---

## 4. How Import Works

### Initial Import (`imports.sh`)

All resources were imported using the `imports.sh` script, which maps each resource to its cloud ID:

```bash
#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_vpc.this' 'vpc-07ab137e2cc49c068'
"$1" import -var-file environments/sg.tfvars 'module.subnet["approvalv2_dev2_privatesubnet1"].aws_subnet.this' 'subnet-03e7a88db06b8263a'
# ... (5 subnet imports)
"$1" import -var-file environments/sg.tfvars 'module.internet_gateway.aws_internet_gateway.this' 'igw-04417c76d78155e2e'
# ... (3 route table imports)
# ... (2 security group imports)
"$1" import -var-file environments/sg.tfvars 'module.network_acl["approvalv2_dev2_nacl"].aws_default_network_acl.this' 'acl-002a010e6f61e9ae6'
"$1" import -var-file environments/sg.tfvars 'module.key_pair["ansible_instance_key"].aws_key_pair.this' 'ansible-instance-key'
```

**Execution:**
```bash
bash imports.sh /path/to/terraform
```

This script was run **once** to populate Terraform state with all discovered resources.

### Re-importing a Single Resource

If state is lost or corrupted, re-import any single resource:

```bash
terraform import -var-file environments/sg.tfvars \
  'module.subnet["approvalv2_dev2_publicsubnet1"].aws_subnet.this' \
  'subnet-047686cbdc216e5a1'
```

Replace the Terraform address and AWS resource ID as needed from the table in **Section 2**.

### State Reconciliation

After import, configuration files (`.tf` and `environments/sg.tfvars`) were adjusted until `terraform plan` showed **0 changes**. This indicates perfect alignment: the state matches the cloud, and the code is consistent with both.

---

## 5. How to Use the Code

### Prerequisites

- Terraform/OpenTofu binary installed (or use the provided `/tmp/tmp.lAPiPa/terraform`)
- AWS credentials configured (`~/.aws/credentials` or `AWS_*` env vars)
- AWS region: `eu-central-1` (hardcoded in `providers.tf`)

### Initialize Terraform

```bash
cd /mnt/sg_workspace/user/sgcode
terraform init
```

This downloads provider plugins and sets up the state backend.

### Plan Changes

To see what would change:

```bash
terraform plan -var-file=environments/sg.tfvars
```

Expected output (after reconciliation): **0 to add, 0 to change, 0 to destroy**.

### Apply Configuration

To apply (create/update/delete resources):

```bash
terraform apply -var-file=environments/sg.tfvars
```

Since the state is already reconciled, this will do nothing unless you've modified the `.tf` files or `tfvars`.

### Targeting a Specific Resource

To apply only one resource (useful for selective changes):

```bash
terraform apply -var-file=environments/sg.tfvars \
  -target='module.subnet["approvalv2_dev2_publicsubnet1"]'
```

### Switching Environments

This code is currently configured for the **dev2** environment (via `environments/sg.tfvars`).

To manage a different environment (e.g., **prod**):

1. **Create a new tfvars file:**
   ```bash
   cp environments/sg.tfvars environments/sg-prod.tfvars
   ```

2. **Edit the new file with production values:**
   ```hcl
   vpc = {
     cidr_block       = "10.30.0.0/16"  # Different CIDR
     instance_tenancy = "default"
     tags = {
       Project    = "approvalv2"
       Enviroment = "prod"
       Name       = "approvalv2-prod-vpc"
     }
   }
   # ... update subnets, security groups, etc.
   ```

3. **Plan with the new file:**
   ```bash
   terraform plan -var-file=environments/sg-prod.tfvars
   ```

4. **No `.tf` files need editing** — only variable values change per environment.

### State File Location

Terraform state is stored in:
- `.terraform/` (local working directory)
- Or a configured remote backend (not set up here; defaults to local)

To check current state:

```bash
terraform state list
terraform state show 'module.vpc.aws_vpc.this'
```

---

## 6. Variables

### Core Input Variables

All variables are defined in `variables.tf` and supplied via `environments/sg.tfvars`. Below are the key ones:

#### `vpc`

**Type:** `object { cidr_block: string, instance_tenancy?: string, tags?: map(string) }`

**Required:** Yes

**Purpose:** VPC configuration — CIDR block, tenancy model, and resource tags.

**Current value (sg.tfvars):**
```hcl
vpc = {
  cidr_block       = "10.20.0.0/16"
  instance_tenancy = "default"
  tags = {
    Project    = "approvalv2"
    Enviroment = "dev2"
    Name       = "approvalv2-dev2-vpc"
  }
}
```

---

#### `subnets`

**Type:** `map(object { cidr_block: string, availability_zone: string, map_public_ip_on_launch?: bool, tags?: map(string) })`

**Required:** No (default: `{}`)

**Purpose:** Map of subnets keyed by name. Each defines CIDR, AZ, public IP assignment, and tags.

**Current value (sg.tfvars):**
```hcl
subnets = {
  "approvalv2_dev2_publicsubnet1" = {
    cidr_block              = "10.20.10.0/24"
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = true
    tags = { ... }
  }
  # ... 4 more subnets
}
```

**Example: Adding a new subnet:**
```hcl
subnets = {
  # ... existing subnets
  "approvalv2_dev2_publicsubnet4" = {
    cidr_block              = "10.20.50.0/24"
    availability_zone       = "eu-central-1c"
    map_public_ip_on_launch = true
    tags = {
      Project    = "approvalv2"
      Enviroment = "dev2"
      Name       = "approvalv2-dev2-PublicSubnet4"
    }
  }
}
```

---

#### `internet_gateway`

**Type:** `object { tags?: map(string) }`

**Required:** No (default: `{}`)

**Purpose:** IGW configuration (currently only tags supported).

**Current value (sg.tfvars):**
```hcl
internet_gateway = {
  tags = {
    Project    = "approvalv2"
    Enviroment = "dev2"
    Name       = "approvalv2-dev2-IGW"
  }
}
```

---

#### `route_tables`

**Type:** `map(object { routes?: list(object { cidr_block?: string, use_igw?: bool }), tags?: map(string) })`

**Required:** No (default: `{}`)

**Purpose:** Map of route tables keyed by name. Each defines routes and tags.

**Route object:**
- `cidr_block` — Destination CIDR (e.g., `"0.0.0.0/0"`)
- `use_igw` — If `true`, this route points to the IGW; if `false`, route is skipped

**Current value (sg.tfvars):**
```hcl
route_tables = {
  "approvalv2_dev2_publicrt" = {
    routes = [
      {
        cidr_block = "0.0.0.0/0"
        use_igw    = true  # Route to IGW
      }
    ]
    tags = { ... }
  }
  "approvalv2_dev2_privatert" = {
    routes = []  # No routes (private subnet)
    tags = { ... }
  }
  "aws_route_table_2" = {
    routes = []
    tags   = {}
  }
}
```

---

#### `security_groups`

**Type:** `map(object { name: string, description: string, ingress?: list(object {...}), egress?: list(object {...}), tags?: map(string) })`

**Required:** No (default: `{}`)

**Purpose:** Map of security groups keyed by name. Each defines ingress/egress rules.

**Rule object (ingress/egress):**
```hcl
{
  from_port   = number              # Start port (0 for all)
  to_port     = number              # End port (0 for all)
  protocol    = string              # "tcp", "udp", "icmp", "-1" (all)
  cidr_blocks = optional(list(string), [])  # CIDR ranges (e.g., ["0.0.0.0/0"])
  description = optional(string, "")        # Rule description
  self        = optional(bool, false)       # Allow self-referencing (SG itself)
}
```

**Current value (sg.tfvars):**
```hcl
security_groups = {
  "approvalv2_dev2_sc1" = {
    name        = "approvalv2-dev2-SC1"
    description = "Allow http, https, and ssh port."
    ingress = [
      { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "Allow http traffic." },
      { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "Allow ssh traffic." },
      { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "Allow https traffic." }
    ]
    egress = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"], description = "Allow Outgoing traffic." }
    ]
    tags = {}
  }
  "default" = {
    name        = "default"
    description = "default VPC security group"
    ingress = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = [], self = true }
    ]
    egress = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
    tags = {}
  }
}
```

---

#### `network_acls`

**Type:** `map(object { default_network_acl_id: string, subnet_keys?: list(string), ingress?: list(object {...}), egress?: list(object {...}), tags?: map(string) })`

**Required:** No (default: `{}`)

**Purpose:** Map of Network ACLs keyed by name. Uses `aws_default_network_acl` to manage the VPC's default NACL.

**Rule object (ingress/egress):**
```hcl
{
  rule_no    = number              # Rule number (1–32766)
  action     = string              # "allow" or "deny"
  protocol   = string              # "tcp", "udp", "icmp", "-1" (all)
  cidr_block = string              # CIDR range (e.g., "0.0.0.0/0")
  from_port  = optional(number, 0) # Start port
  to_port    = optional(number, 0) # End port
}
```

**Current value (sg.tfvars):**
```hcl
network_acls = {
  "approvalv2_dev2_nacl" = {
    default_network_acl_id = "acl-002a010e6f61e9ae6"
    subnet_keys = [
      "approvalv2_dev2_publicsubnet2",
      "approvalv2_dev2_publicsubnet1",
      "approvalv2_dev2_privatesubnet2",
      "approvalv2_dev2_publicsubnet3",
      "approvalv2_dev2_privatesubnet1"
    ]
    ingress = [
      { rule_no = 100, action = "allow", protocol = "-1", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0 }
    ]
    egress = [
      { rule_no = 100, action = "allow", protocol = "-1", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0 }
    ]
    tags = {}
  }
}
```

**Note:** `subnet_keys` is a list of subnet map keys (not IDs). The root module maps these to actual subnet IDs via:
```hcl
subnet_ids = [for s in each.value.subnet_keys : module.subnet[s].subnet_id]
```

---

#### `key_pairs`

**Type:** `map(object { key_name: string, public_key?: string, tags?: map(string) })`

**Required:** No (default: `{}`)

**Purpose:** Map of EC2 key pairs keyed by name.

**Current value (sg.tfvars):**
```hcl
key_pairs = {
  "ansible_instance_key" = {
    key_name   = "ansible-instance-key"
    public_key = "placeholder"
  }
}
```

**Important:** The `public_key` value is **write-only** — AWS API never returns it. The value `"placeholder"` is a dummy string. The module's `lifecycle { ignore_changes = [public_key] }` prevents Terraform from detecting drift on this field.

**To use a real key:**
1. Generate or obtain the SSH public key (e.g., from `ssh-keygen` or AWS)
2. Update the tfvars:
   ```hcl
   key_pairs = {
     "ansible_instance_key" = {
       key_name   = "ansible-instance-key"
       public_key = "ssh-rsa AAAA... your-key"
     }
   }
   ```
3. Re-run `terraform plan` and `terraform apply`

---

### Sensitive Variables

**No sensitive variables are used in this code.** All values are in `environments/sg.tfvars` as plain text (suitable for non-secret configuration).

If you need to manage secrets (e.g., database passwords, API keys), create a `secrets.auto.tfvars` file in the root directory and add new sensitive variables to `variables.tf` with `sensitive = true`.

---

## 7. Infrastructure Graph

```
aws_vpc.this (vpc-07ab137e2cc49c068)
│
├─→ aws_subnet.this["approvalv2_dev2_publicsubnet1"]  (subnet-047686cbdc216e5a1)
│   └─→ aws_default_network_acl.this (acl-002a010e6f61e9ae6) — ingress/egress rules
│
├─→ aws_subnet.this["approvalv2_dev2_publicsubnet2"]  (subnet-07971bba1b7a42270)
│   └─→ aws_default_network_acl.this (acl-002a010e6f61e9ae6)
│
├─→ aws_subnet.this["approvalv2_dev2_publicsubnet3"]  (subnet-0b2bfeab9b9600478)
│   └─→ aws_default_network_acl.this (acl-002a010e6f61e9ae6)
│
├─→ aws_subnet.this["approvalv2_dev2_privatesubnet1"] (subnet-03e7a88db06b8263a)
│   └─→ aws_default_network_acl.this (acl-002a010e6f61e9ae6)
│
├─→ aws_subnet.this["approvalv2_dev2_privatesubnet2"] (subnet-0ac80964ef0acb99c)
│   └─→ aws_default_network_acl.this (acl-002a010e6f61e9ae6)
│
├─→ aws_internet_gateway.this (igw-04417c76d78155e2e)
│   └─→ aws_route_table.this["approvalv2_dev2_publicrt"] (route: 0.0.0.0/0 → IGW)
│
├─→ aws_route_table.this["approvalv2_dev2_publicrt"]  (rtb-08004bb274b987779)
│   └─→ Associated subnets:
│       ├─ approvalv2_dev2_publicsubnet1 (via AWS subnet association)
│       └─ approvalv2_dev2_publicsubnet2 (via AWS subnet association)
│
├─→ aws_route_table.this["approvalv2_dev2_privatert"] (rtb-0f7772eb68094bb1e)
│   └─→ Associated subnets:
│       ├─ approvalv2_dev2_privatesubnet1 (via AWS subnet association)
│       └─ approvalv2_dev2_privatesubnet2 (via AWS subnet association)
│
├─→ aws_route_table.this["aws_route_table_2"]        (rtb-0a8623f5c98b5f651) — Main/default
│   └─→ Associated to VPC (no explicit subnet association)
│
├─→ aws_security_group.this["approvalv2_dev2_sc1"]    (sg-016209b903a312283)
│   └─→ Rules (dynamic ingress/egress):
│       ├─ Ingress: 22/tcp from 0.0.0.0/0
│       ├─ Ingress: 80/tcp from 0.0.0.0/0
│       ├─ Ingress: 443/tcp from 0.0.0.0/0
│       └─ Egress: all protocols to 0.0.0.0/0
│
├─→ aws_security_group.this["default"]               (sg-08ddee24b0704317a)
│   └─→ Rules (dynamic ingress/egress):
│       ├─ Ingress: all from self (SG itself)
│       └─ Egress: all protocols to 0.0.0.0/0
│
└─→ aws_key_pair.this["ansible_instance_key"]        (ansible-instance-key)
    └─→ Lifecycle: ignore_changes = [public_key] (write-only attribute)

Legend:
  ─→  References / Depends on
  └─→ Contains or manages
```

**Key dependencies:**
- All subnets depend on VPC (vpc_id)
- All route tables depend on VPC (vpc_id)
- Public route table depends on IGW (internet_gateway_id)
- Default NACL depends on all subnets (subnet_ids)
- All security groups depend on VPC (vpc_id)
- Key pairs are standalone (no dependencies)

---

## 8. Notable Decisions & Caveats

### Default Network ACL

The VPC has a default NACL (`acl-002a010e6f61e9ae6`) that AWS creates automatically. Instead of importing it as a regular `aws_network_acl` (which would try to replace it), we use `aws_default_network_acl` to manage it in-place. This resource modifies the default NACL's rules and subnet associations without destroying and recreating it.

### AWS Default-Deny Rule (Rule 32767)

AWS automatically adds a default-deny rule with rule_no=32767 to all NACLs. Terraform only allows rule numbers 1–32766, so this rule cannot be explicitly managed in code. It exists implicitly and is never shown in `terraform state` or `plan`. This is expected behavior and requires no action.

### CloudFormation Tags

The discovered resources were created via CloudFormation stacks and carry tags like:
- `aws:cloudformation:stack-name`
- `aws:cloudformation:stack-id`
- `aws:cloudformation:logical-id`

These are **read-only** and managed by CloudFormation, not returned by the AWS API in the tags listing. Only the 3 user-managed tags (Project, Enviroment, Name) are stored in state and appear in `tfvars`. The CloudFormation tags remain on the cloud resources but are not replicated in Terraform state — this is acceptable as they serve CloudFormation's internal tracking.

### Default Security Group

The VPC's default security group (`sg-08ddee24b0704317a`) is managed as a regular `aws_security_group` resource, not a special default resource. Its ingress rule uses `self = true` to allow all traffic from the security group itself (standard default SG behavior).

### Key Pair Public Key (Write-Only)

The `aws_key_pair` resource has a `public_key` argument that is **write-only**: the AWS API accepts it during creation but never returns it during reads. The value in `tfvars` is set to `"placeholder"` because the real public key is unavailable from discovery data.

**Solution:** The module applies `lifecycle { ignore_changes = [public_key] }` to prevent Terraform from detecting drift on every plan. If you need to rotate the key, update the `tfvars` value and re-apply; the change will be detected and applied (a new key will replace the old one).

### Unmanaged Resources

The following resources are present in AWS but are **NOT managed by this Terraform code:**

| Resource | Why Excluded |
|---|---|
| EC2 instance `i-0c452bc6fe2c3972b` (ec2-sg) | Managed by a separate workflow (`/wfgrps/App-Team-Dev/wfs/ec2-sg`); `sg_drifted` status |
| IAM instance profile `ec2-terminator-profile-9a24ca84` | Managed by ephemeral EC2 workflow; `sg_drifted` status |
| Key pairs `key-008ace2d46a1820b3`, `key-009b76ed3cba6a9ea` | Unmanaged terraform keys; created outside this workflow |
| CloudFormation stacks `vpc-1`, `StackGuardianConnectorRole` | Unmanaged CloudFormation; not in IaC scope |

These resources will not be destroyed or modified by `terraform apply`.

### Subnet Association with Route Tables

Subnet-to-route-table associations are created at the **cloud level** (AWS automatically associates subnets with route tables via `aws_subnet_route_table_association` or similar), but this code does not explicitly define these associations. They are inferred from the data discovered and should exist in the real AWS environment. If you need to change associations, they would typically be managed as separate resources (`aws_route_table_association`) — not currently in scope.

### No Outputs at Root

The root module has no outputs (`outputs.tf` is empty). All outputs are contained within individual modules (e.g., `module.vpc.vpc_id`, `module.subnet[...].subnet_id`). This keeps the code modular and allows consumers to reference specific module outputs as needed.

### Plan Status: Clean

After reconciliation, `terraform plan -var-file=environments/sg.tfvars` shows:
```
No changes. Your infrastructure matches the configuration.
```

This indicates that state and code are perfectly synchronized. If you see any changes, investigate whether:
1. `tfvars` values were edited (intentionally)
2. Cloud resources were modified outside Terraform (drift detection)
3. A new variable was added to `variables.tf` but not to `tfvars` (missing value)

---

**End of Documentation**

Generated for **approvalv2-dev2** infrastructure in **eu-central-1** region.
Last reconciled: 0 changes detected.
