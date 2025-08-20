variable "business_area_name" {
  description = "Business area - Integrated Data Services"
  type        = string
  default     = "idc"
}

variable "team_name" {
  description = "Name of the team - Digital Product Catalog"
  type        = string
  default     = "dpc"
}

variable "framework_prefix" {
  description = "What IaC tool is being used for this deployment?"
  type        = string
  default     = "tf"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "aws_account_setup"
}

variable "iam_role_name" {
  description = "Name of the role being created"
  type        = string
  default     = "github_oidc_assume_role"
}

variable "git_repo_name" {
  description = "Name of git repo"
  type        = string
  default     = "spring-boot-with-aws-secrets-manager"
}

variable "account_tools" {
  description = "Aws account number"
  type        = string
  default     = "792981815698"
}

variable "account_non_prod" {
  description = "Aws account number"
  type        = string
  default     = "998530368070"
}

variable "account_prod" {
  description = "Aws account number"
  type        = string
  default     = "NOT-DEFINED"
}

variable "current_account" {
  description = "Which account is currently selected"
  type        = string
  default     = ""
}

variable "environment_abv" {
  description = "Name of environment"
  type        = string
  default     = "brr"
}

variable "tag_environment_tools" {
  description = "Name of environment"
  type        = string
  default     = "BRR-TOOLS"
}

variable "tag_environment_non_prod" {
  description = "Name of environment"
  type        = string
  default     = "BRR-NP"
}

variable "tag_environment_prod" {
  description = "Name of environment"
  type        = string
  default     = "BRR-PROD"
}

variable "tag_name" {
  description = "Resource name"
  type        = string
  default     = ""
}

variable "tag_origination_repo" {
  description = "Name of the repository that contains the code that controls this resource"
  type        = string
  default     = "dpc-base-cloud-resources"
}

variable "github_pat_2025" {
  description = "GitHub PAT with repo and actions permissions (optional if using env var)"
  type = string
  default = ""
  sensitive = true
}