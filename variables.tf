variable "region" {
  description = "AWS region"
  type        = string
}

variable "cloudformation_stacks" {
  description = "Map of CloudFormation stacks to manage"
  type = map(object({
    name             = string
    capabilities     = list(string)
    disable_rollback = bool
    parameters       = map(string)
  }))
}