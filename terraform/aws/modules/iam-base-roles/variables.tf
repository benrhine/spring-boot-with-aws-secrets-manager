########################################################################################################################
# Variable must be defined in order for the module to receive the arn in order to limit which roles can assume the base
# role.
########################################################################################################################

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

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "INSERT-PROJECT-NAME"
}

variable "deployment_bucket_name" { # This value is used in the module data.tf
  description = "Name of the S3 bucket which resources are deployed to"
  type        = string
  default     = "*"
}

variable "aws_codepipeline_project_name" {
  description = "Name of the given pipeline"
  type        = string
  default     = "N/A"
}