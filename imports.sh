#!/bin/sh
set -e

terraform import -var-file=environments/terraform.tfvars module.vpc_name.aws_vpc.this vpc-024344e8549773d40
terraform import -var-file=environments/terraform.tfvars module.vpc_name_public_subnet.aws_subnet.this subnet-0b77c0d76befaf70d
terraform import -var-file=environments/terraform.tfvars module.sg_runner_new_security_group.aws_security_group.this sg-0d2894f23f4b8f7e7
terraform import -var-file=environments/terraform.tfvars 'module.sg_runner_new_security_group.aws_security_group_rule.this["ssh_ingress"]' sg-0d2894f23f4b8f7e7_ingress_tcp_22_22_115.96.62.109/32
terraform import -var-file=environments/terraform.tfvars 'module.sg_runner_new_security_group.aws_security_group_rule.this["egress_all"]' sg-0d2894f23f4b8f7e7_egress_all_0_0_0.0.0.0/0
terraform import -var-file=environments/terraform.tfvars module.clara_key_pair.aws_key_pair.this clara-sg-privaterunner
terraform import -var-file=environments/terraform.tfvars module.sg_runner_instance_profile.aws_iam_instance_profile.this SG_RUNNER_new-runner-instance-profile
terraform import -var-file=environments/terraform.tfvars module.eni_02b2519b0f908256d.aws_network_interface.this eni-02b2519b0f908256d
terraform import -var-file=environments/terraform.tfvars 'module.instances.aws_instance.this["i_000e597ea8aa8260b"]' i-000e597ea8aa8260b
terraform import -var-file=environments/terraform.tfvars 'module.instances.aws_instance.this["sg_runner_new_private_runner_asg"]' i-0073fcf5e556169e8
terraform import -var-file=environments/terraform.tfvars 'module.instances.aws_instance.this["i_007e6212f82fd1d38"]' i-007e6212f82fd1d38
terraform import -var-file=environments/terraform.tfvars 'module.instances.aws_instance.this["ecs_instances_admin_workflow_qa"]' i-010c68975b065af78
terraform import -var-file=environments/terraform.tfvars 'module.instances.aws_ebs_volume.this["vol_0f5a54343d85c2ca9"]' vol-0f5a54343d85c2ca9
terraform import -var-file=environments/terraform.tfvars 'module.instances.aws_volume_attachment.this["vol_0f5a54343d85c2ca9_attachment"]' /dev/sda1:vol-0f5a54343d85c2ca9:i-0073fcf5e556169e8