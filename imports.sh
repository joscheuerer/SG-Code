#!/bin/sh
set -e
# NOTE: azurerm_management_group_policy_assignment imports below fail with
# 403 AuthorizationFailed (platform-managed credential lacks
# policyAssignments/read at the management group scope). Kept for reference;
# not run automatically. Excluded from environments/sg.tfvars until access
# is granted upstream.
# "$1" import -var-file environments/sg.tfvars 'module.policy_assignment["_preview___users_must_authenticate_with_multi_factor_authentication_to_create_or_update_resources"].azurerm_management_group_policy_assignment.this' '/providers/Microsoft.Management/managementGroups/e486c990-3cab-4813-a86a-77b4c6b8f3d6/providers/Microsoft.Authorization/policyAssignments/30d3965d762745f496b7330d'
# "$1" import -var-file environments/sg.tfvars 'module.policy_assignment["_preview___users_must_authenticate_with_multi_factor_authentication_to_delete_resources"].azurerm_management_group_policy_assignment.this' '/providers/Microsoft.Management/managementGroups/e486c990-3cab-4813-a86a-77b4c6b8f3d6/providers/Microsoft.Authorization/policyAssignments/65ffe745b4544d1cb1251371'
# "$1" import -var-file environments/sg.tfvars 'module.policy_assignment["microsoft_azure_multi_factor_authentication_enforcement_for_resource_write_actions"].azurerm_management_group_policy_assignment.this' '/providers/Microsoft.Management/managementGroups/e486c990-3cab-4813-a86a-77b4c6b8f3d6/providers/Microsoft.Authorization/policyAssignments/sys.mfa-write'

"$1" import -var-file environments/sg.tfvars 'module.role_assignment["r_08a0436e_18f0_4626_a803_168e302a52f7"].azurerm_role_assignment.this' '/subscriptions/a97621d8-9158-4681-81b6-38b1222afba4/providers/Microsoft.Authorization/roleAssignments/08a0436e-18f0-4626-a803-168e302a52f7'

# NOTE: role assignments below have scope "/" (Azure AD / tenant-root
# directory role assignment). azurerm provider v3.117.1 cannot parse or
# operate on scope "/" for azurerm_role_assignment (resource-id parsing
# requires subscription/resourceGroup/managementGroup segments). Excluded
# from environments/sg.tfvars — genuine provider limitation, not an auth issue.
# "$1" import -var-file environments/sg.tfvars 'module.role_assignment["r_8c33f5e2_222f_4d11_86a8_9cd8e8e7d215"].azurerm_role_assignment.this' '/providers/Microsoft.Authorization/roleAssignments/8c33f5e2-222f-4d11-86a8-9cd8e8e7d215'
# "$1" import -var-file environments/sg.tfvars 'module.role_assignment["r_8e90d35e_48b2_453b_a6e6_c146f9bf731d"].azurerm_role_assignment.this' '/providers/Microsoft.Authorization/roleAssignments/8e90d35e-48b2-453b-a6e6-c146f9bf731d'
