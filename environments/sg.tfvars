region = "eu-central-1"

cloudformation_stacks = {
  stackguardian_connector_role = {
    name             = "StackGuardianConnectorRole"
    capabilities     = ["CAPABILITY_NAMED_IAM"]
    disable_rollback = false
    parameters       = {}
  }
  vpc_1 = {
    name             = "vpc-1"
    capabilities     = ["CAPABILITY_IAM"]
    disable_rollback = false
    parameters       = {}
  }
  vpc_2 = {
    name             = "vpc-2"
    capabilities     = ["CAPABILITY_IAM"]
    disable_rollback = false
    parameters       = {}
  }
}