########################################################################################################################
# Variable must be defined in order for the module to receive the arn in order to limit which roles can assume the base
# role.
########################################################################################################################

variable "pipeline_name" {
  description = "Name of the pipeline"
  type        = string
#   default = "" # By not setting a default makes it a required field
}

variable "service_role_arn" { # This value is used in the module data.tf
  description = "Service role ARN required for execution"
  type        = string
#   default = "" # By not setting a default makes it a required field
}

variable "deployment_bucket" { # This value is used in the module data.tf
  description = "Name of the S3 bucket which resources are deployed to"
  type        = string
#   default = "" # By not setting a default makes it a required field
}

variable "artifact_store_type" { # This value is used in the module data.tf
  description = "Resource type of where artifact is stored"
  type        = string
  default     = "S3"
}

variable "git_repo_name" {
  description = "Name of git repo"
  type        = string
#   default = "" # By not setting a default makes it a required field
}

variable "codebuild_project" {
  description = "CodeBuild project name"
  type        = string
#   default = "" # By not setting a default makes it a required field
}

variable "stage_1_name" { # This value is used in the module data.tf
  description = "Stage 1 name"
  type        = string
  default     = "code-commit-checkout"
}

variable "stage_1_action_name" {
  description = "Stage 1 action name"
  type        = string
  default     = "Source"
}

variable "stage_1_action_category" {
  description = "Stage 1 action category"
  type        = string
  default     = "Source"
}

variable "stage_1_action_owner" {
  description = "Stage 1 action owner"
  type        = string
  default     = "AWS"
}

variable "stage_1_action_provider" {
  description = "Stage 1 action provider"
  type        = string
  default     = "CodeCommit"
}

variable "stage_1_action_version" {
  description = "Stage 1 action version"
  type        = string
  default     = "1"
}

variable "stage_1_action_output_artifacts" {
  description = "Stage 1 action output artifacts"
  type        = list(string)
  default     = ["SourceArtifact"]
}

variable "stage_1_action_namespace" {
  description = "Stage 1 action namespace"
  type        = string
  default     = "SourceVariables"
}

variable "stage_1_action_configuration_output_artifact_format" {
  description = "Output type"
  type        = string
  default     = "CODE_ZIP"
}

variable "stage_1_action_configuration_poll_for_source_changes" {
  description = "Watch for source changes"
  type        = bool
  default     = false
}

variable "stage_1_action_configuration_branch_name" {
  description = "Git branch name"
  type        = string
  default     = "main"
}

variable "pipeline_tags_project" {
  description = "What project is this part of?"
  type        = string
  nullable    = true
  #   default = "" # By not setting a default makes it a required field UNLESS nullable is true
}

variable "pipeline_tags_environment" {
  description = "What environment is this deployed to?"
  type        = string
  nullable    = true
  #   default = "" # By not setting a default makes it a required field UNLESS nullable is true
}

variable "pipeline_tags_origination" {
  description = "What repository is this deployed from?"
  type        = string
  nullable    = true
  #   default     = "INSERT-ENVIRONMENT-NAME"
}
