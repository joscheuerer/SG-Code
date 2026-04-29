# akshat-12-apr-vm-stack

## Description

Azure Virtual Machine stack with managed disks, network interface, and network security group for akshat-12-Apr. Deployed in the `germanywestcentral` region.

## Stack Overview

This stack provisions the following Azure resources:

| Module | Description |
|--------|-------------|
| `network_security_group` | Network Security Group with SSH (port 22) inbound allow rule |
| `network_interface` | Network Interface attached to an existing subnet |
| `managed_disk` | Managed disks (data disk and OS disk) |
| `virtual_machine` | Linux Virtual Machine (Ubuntu 24.04 LTS) with SSH key authentication |

## Module Details

### network_security_group
- Creates an NSG named `akshat-12-Apr-nsg` in resource group `adis`
- Allows inbound SSH (TCP/22) from any source at priority 1000

### network_interface
- Creates NIC `akshat-12-apr966_z1` in resource group `adis`
- Attached to subnet in `sg-runner-vnet` (resource group `adis-eu`)
- Dynamic IPv4 allocation, accelerated networking disabled

### managed_disk
- `akshat-12-Apr_DataDisk_0`: 4 GB Premium LRS data disk
- `akshat-12-Apr_OsDisk_1_6457833762cd4ee48bf9e0dbee5f3cb8`: 30 GB StandardSSD LRS OS disk

### virtual_machine
- VM size: `Standard_B2ms`, Zone: `1`
- Image: Canonical Ubuntu 24.04 LTS
- Admin user: `azureuser` with SSH key authentication
- Data disk attached at LUN 0

## Variables Reference

| Variable | Type | Description |
|----------|------|-------------|
| `region` | string | Azure region for all resources |
| `nsg_name` | string | Name of the NSG |
| `nsg_resource_group_name` | string | Resource group for the NSG |
| `nsg_tags` | map(string) | Tags for the NSG |
| `nic_name` | string | Name of the NIC |
| `nic_resource_group_name` | string | Resource group for the NIC |
| `nic_accelerated_networking_enabled` | bool | Accelerated networking toggle |
| `nic_ip_forwarding_enabled` | bool | IP forwarding toggle |
| `nic_subnet_id` | string | Subnet ID for NIC |
| `nic_tags` | map(string) | Tags for the NIC |
| `managed_disks` | map(object) | Map of managed disk configurations |
| `vm_name` | string | Name of the VM |
| `vm_resource_group_name` | string | Resource group for the VM |
| `vm_size` | string | VM size SKU |
| `vm_zones` | list(string) | Availability zones |
| `vm_image_publisher` | string | Image publisher |
| `vm_image_offer` | string | Image offer |
| `vm_image_sku` | string | Image SKU |
| `vm_image_version` | string | Image version |
| `vm_os_disk_name` | string | OS disk name |
| `vm_os_disk_caching` | string | OS disk caching mode |
| `vm_os_type` | string | OS type |
| `vm_data_disk_name` | string | Data disk name |
| `vm_data_disk_size_gb` | number | Data disk size in GB |
| `vm_data_disk_managed_disk_type` | string | Data disk storage type |
| `vm_computer_name` | string | VM computer name |
| `vm_admin_username` | string | Admin username |
| `vm_disable_password_authentication` | bool | Disable password auth (sensitive) |
| `vm_ssh_public_key_data` | string | SSH public key (sensitive) |
| `vm_tags` | map(string) | Tags for the VM |

## Outputs Reference

| Output | Description |
|--------|-------------|
| `nsg_id` | The ID of the Network Security Group |
| `nic_id` | The ID of the Network Interface |
| `vm_id` | The ID of the Virtual Machine |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import existing resources

```sh
./imports.sh terraform
# or with OpenTofu:
./imports.sh tofu
```

### 3. Plan

```sh
terraform plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```

> **Note:** Sensitive variables (`vm_disable_password_authentication`, `vm_ssh_public_key_data`) must be supplied via environment variables or a secrets manager — do not commit them to source control.