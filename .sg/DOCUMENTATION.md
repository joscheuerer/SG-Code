# Launch Templates Stack

## Overview

This Terraform stack manages AWS EC2 Launch Templates in the `eu-central-1` region. It imports and manages existing launch templates with their version configurations.

## Architecture

The stack consists of a single module that manages multiple launch templates using a map-based configuration approach.

### Modules

#### launch_template

Manages EC2 launch templates with version tracking.

**Resources:**
- `aws_launch_template.this` - EC2 launch templates (for_each)

**Capabilities:**
- Creates and manages launch templates
- Tracks default and latest versions
- Supports multiple templates via map configuration

## Variables

### Root Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region | - |
| launch_templates | map(object) | Launch templates to create | - |

### Module Variables

#### launch_template

| Name | Type | Description | Default |
|------|------|-------------|---------|
| launch_templates | map(object) | Launch templates to create | {} |

## Outputs

### Root Outputs

| Name | Description |
|------|-------------|
| launch_template_ids | Map of launch template IDs |
| launch_template_arns | Map of launch template ARNs |

### Module Outputs

#### launch_template

| Name | Description |
|------|-------------|
| launch_template_ids | Map of launch template IDs |
| launch_template_arns | Map of launch template ARNs |

## Usage

### Initial Setup

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Import Existing Resources:**
   ```bash
   chmod +x imports.sh
   ./imports.sh
   ```

3. **Verify Configuration:**
   ```bash
   terraform plan -var-file=environments/terraform.tfvars
   ```
   
   This should show no changes after import, confirming zero drift.

4. **Apply Configuration:**
   ```bash
   terraform apply -var-file=environments/terraform.tfvars
   ```

### Managing Launch Templates

The stack manages three launch templates:
- `one-2025080507384391980000000e` (v1)
- `taher-private-runner` (v11 default, v12 latest)
- `SG_QA_ORG_DASH_PRIVATE_RUNNER-private-runner-20251231115633025100000001` (v1 default, v2 latest)

To modify launch templates, update the `launch_templates` variable in `environments/terraform.tfvars` and apply changes.

### Accessing Outputs

```bash
terraform output launch_template_ids
terraform output launch_template_arns
```

## Notes

- This stack imports existing AWS resources and maintains zero drift
- Launch template versions are read-only attributes managed by AWS
- The `default_version` and `latest_version` attributes track version state but cannot be directly modified
- All launch templates are managed through the single module instance