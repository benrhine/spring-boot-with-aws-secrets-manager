########################################################################################################################
# Variable must be defined in order for the module to receive the arn in order to limit which roles can assume the base
# role.
########################################################################################################################

# Allows for region to be passed in from calling module OR defaults to current execution environment retrieved in data.tf
# variable "aws_region" {
#   description = "AWS region"
#   type        = string
# }
#
# # Allows for region to be passed in from calling module OR defaults to current execution environment retrieved in data.tf
# variable "aws_account" {
#   description = "AWS Account"
#   type        = string
# }
#
# variable "project_name" {
#   description = "Name of the project"
#   type        = string
#   default     = "INSERT-PROJECT-NAME"
# }

variable "iam_role_name" {
  description = "Name of the role"
  type        = string
}

variable "iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = "IAM role created by Terraform"
}

variable "iam_role_path" {
  description = "Path to the role"
  type        = string
  default     = "/"
}

variable "iam_assume_role_policy" {
  description = "Trust policy"
  type        = string
}

variable "iam_tags_project" {
  description = "What project is this part of?"
  type        = string
  nullable    = true
  #   default = "" # By not setting a default makes it a required field UNLESS nullable is true
}

variable "iam_tags_environment" {
  description = "What environment is this deployed to?"
  type        = string
  nullable    = true
  #   default     = "INSERT-ENVIRONMENT-NAME"
}

variable "iam_tags_origination" {
  description = "What repository is this deployed from?"
  type        = string
  nullable    = true
  #   default     = "INSERT-ENVIRONMENT-NAME"
}

