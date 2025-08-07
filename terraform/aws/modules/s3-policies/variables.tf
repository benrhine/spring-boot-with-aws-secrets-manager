########################################################################################################################
# Variable must be defined in order for the module to receive the arn in order to limit which roles can assume the base
# role.
########################################################################################################################

variable "framework_prefix" {
  description = "What IaC tool is being used for this deployment?"
  type        = string
  default     = "tf"
}

# Allows for region to be passed in from calling module OR defaults to current execution environment retrieved in data.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
}

# Allows for region to be passed in from calling module OR defaults to current execution environment retrieved in data.tf
variable "aws_account" {
  description = "AWS Account"
  type        = string
}

variable "account_tools" {
  description = "Aws account number"
  type        = string
}

variable "account_non_prod" {
  description = "Aws account number"
  type        = string
}

variable "account_prod" {
  description = "Aws account number"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "INSERT-PROJECT-NAME"
}

variable "bucket_id" { # This value is used in the module data.tf
  description = "The specific id for a given bucket"
  type        = string
}

variable "bucket_arn" { # This value is used in the module data.tf
  description = "The specific ARN to apply the policy to"
  type        = string
}

variable "bucket_policy_identifiers_name" { # This value is used in the module data.tf
  description = "Role that is allowed access to S3 bucket"
  type        = string
}

# variable "bucket_policy_identifiers_names" {
#   type    = list(string)
#   default = [
#   ]
# }

# This is how you get around using a variable in a variable
# https://www.google.com/search?client=safari&rls=en&q=terrafrom+reference+variable+in+a+variable&ie=UTF-8&oe=UTF-8

locals {
  bucket_policy_identifiers = [
    "arn:aws:iam::${var.account_non_prod}:role/${var.bucket_policy_identifiers_name}",
    # "arn:aws:iam::${var.account_prod}:role/${var.framework_prefix}-external-service-role"
  ]
}

# variable "bucket_policy_resources" {
#   type    = list(string)
#   default = [
#     var.bucket_arn,
#     join("/", [var.bucket_arn, "*"])
#   ]
# }

variable "bucket_policy_allowed_actions" {
  type    = list(string)
  default = [
    "s3:Get*",
    "s3:ListBucket",
    "s3:GetLifecycleConfiguration",
    "s3:PutObject",
    "s3:DeleteObject"
  ]
}
