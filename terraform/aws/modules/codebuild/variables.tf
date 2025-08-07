########################################################################################################################
# Variable must be defined in order for the module to receive the arn in order to limit which roles can assume the base
# role.
########################################################################################################################

variable "build_name" {
  description = "Name of the project"
  type        = string
}

variable "build_description" {
  description = "Name of the project"
  type        = string
  default     = "CodeBuild job"
}

variable "build_timeout" {
  description = "Name of the project"
  type        = number
  default     = 5
}

variable "service_role_arn" { # This value is used in the module data.tf
  description = "Service role ARN required for execution"
  type        = string
#   default = "" # By not setting a default makes it a required field
}

variable "build_badge_enabled" {
  description = "CodeBuild badge enabled (true/false)"
  type        = bool
  default     = true
}

variable "git_source_type" {
  description = "What type of git repository is it"
  type        = string
  default     = "GITHUB"
}

variable "git_source_version" {
  description = "The branch or commit that should be checked out"
  type        = string
  default     = "refs/heads/main"
}

variable "git_repo_name" {
  description = "Name of git repo"
  type        = string
#   default = "" # By not setting a default makes it a required field
}

variable "git_repo_location" {
  description = "Full location of git repository"
  type        = string
#   default = "" # By not setting a default makes it a required field
}

variable "git_repo_buildspec" {
  description = "Location of buildspec"
  type        = string
}

variable "git_clone_depth" {
  description = "How deep to clone - 0 Represents a full checkout which is necessary for git commands"
  type        = number
  default     = 0
}

variable "git_fetch_submodules" {
  description = "Fetch submodules?"
  type        = bool
  default     = false
}

variable "artifacts" {
  description = "What type of artifact is produced"
  type        = string
  default     = "NO_ARTIFACTS"
}

variable "env_type" {
  description = "What type of environment is it"
  type        = string
  default     = "LINUX_CONTAINER"
}

variable "env_compute_type" {
  description = "What kind / how many resources to assign"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "env_image" {
  description = "What image to use to perform CodeBuild"
  type        = string
  default     = "aws/codebuild/standard:7.0"
}

variable "env_image_pull_credentials_type" {
  description = "What image credentials to use"
  type        = string
  default     = "CODEBUILD"
}

variable "cloudwatch_logs" {
  description = "Are CloudWatch logs enabled"
  type        = string
  default     = "ENABLED"
}

variable "s3_logs" {
  description = "Are S3 logs enabled"
  type        = string
  default     = "DISABLED"
}

variable "env_tags_project" {
  description = "What project is this part of?"
  type        = string
  nullable    = true
  #   default = "" # By not setting a default makes it a required field UNLESS nullable is true
}

variable "env_tags_environment" {
  description = "What environment is this deployed to?"
  type        = string
  nullable    = true
#   default = "" # By not setting a default makes it a required field UNLESS nullable is true
}

variable "env_tags_origination" {
  description = "What repository is this deployed from?"
  type        = string
  nullable    = true
  #   default     = "INSERT-ENVIRONMENT-NAME"
}
