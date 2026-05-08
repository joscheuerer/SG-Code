#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.iam_role.aws_iam_role.this' 'AmazonEKSAutoClusterRole'
"$1" import -var-file environments/sg.tfvars 'module.iam_role.aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]' 'AmazonEKSAutoClusterRole/arn:aws:iam::aws:policy/AmazonEKSClusterPolicy'
"$1" import -var-file environments/sg.tfvars 'module.iam_role.aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"]' 'AmazonEKSAutoClusterRole/arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy'
"$1" import -var-file environments/sg.tfvars 'module.iam_role.aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKSComputePolicy"]' 'AmazonEKSAutoClusterRole/arn:aws:iam::aws:policy/AmazonEKSComputePolicy'
"$1" import -var-file environments/sg.tfvars 'module.iam_role.aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"]' 'AmazonEKSAutoClusterRole/arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy'
"$1" import -var-file environments/sg.tfvars 'module.iam_role.aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"]' 'AmazonEKSAutoClusterRole/arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy'
"$1" import -var-file environments/sg.tfvars 'module.eks_cluster.aws_eks_cluster.this' 'scrumptious-lofi-gopher'
"$1" import -var-file environments/sg.tfvars 'module.s3_bucket.aws_s3_bucket.this' 'test-new-2026'