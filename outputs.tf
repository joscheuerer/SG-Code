output "ebs_csi_policy_arn" {
  value       = module.ebs_csi_policy.policy_arn
  description = "ARN of the EBS CSI driver IAM policy"
}

output "ebs_csi_policy_id" {
  value       = module.ebs_csi_policy.policy_id
  description = "ID of the EBS CSI driver IAM policy"
}