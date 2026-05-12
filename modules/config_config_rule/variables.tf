variable "name" {
  type        = string
  description = "The name of the AWS Config rule"
}

variable "description" {
  type        = string
  description = "Description of the AWS Config rule"
}

variable "evaluation_mode" {
  type        = string
  description = "The mode of evaluation for the Config rule"
}

variable "compliance_resource_types" {
  type        = list(string)
  description = "A list of resource types that trigger evaluation for the rule"
}

variable "source_owner" {
  type        = string
  description = "Indicates whether AWS or the customer owns and manages the Config rule"
}

variable "source_identifier" {
  type        = string
  description = "For AWS Config managed rules, the predefined identifier"
}