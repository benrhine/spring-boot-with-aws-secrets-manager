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

variable "create_bucket_name" {
  description = "Name of the S3 bucket to create"
  type        = string
  default     = "INSERT-BUCKET-NAME"
}

variable "s3_tags_project" {
  description = "What project is this part of?"
  type        = string
  nullable    = true
  #   default = "" # By not setting a default makes it a required field UNLESS nullable is true
}

variable "s3_tags_environment" {
  description = "What environment is this deployed to?"
  type        = string
  nullable    = true
  #   default     = "INSERT-ENVIRONMENT-NAME"
}

variable "s3_tags_origination" {
  description = "What repository is this deployed from?"
  type        = string
  nullable    = true
  #   default     = "INSERT-ENVIRONMENT-NAME"
}

variable "create_bucket_sse_algorithm" {
  description = "Type of server side encryption applied to bucket"
  type        = string
  default     = "AES256"
}

variable "create_bucket_block_public_acls" {
  description = "Block public acls (true/false)"
  type        = bool
  default     = true
}

variable "create_bucket_block_public_policy" {
  description = "Block public policy (true/false)"
  type        = bool
  default     = true
}

variable "create_bucket_ignore_public_acls" {
  description = "Ignore public acls (true/false)"
  type        = bool
  default     = true
}

variable "create_bucket_restrict_public_buckets" {
  description = "Restrict public buckets (true/false)"
  type        = bool
  default     = true
}