# Values Overridden by TFVARS ==================================================
## Terraform

## Git
variable "github_token" {
  description = "GitHub PAT with repo and actions permissions (optional if using env var)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "git_org_name" {
  description = "Name of git org"
  type        = string
  default     = "benrhine"
}

variable "git_repo_name" {
  description = "Name of git repo"
  type        = string
  default     = "spring-boot-with-aws-secrets-manager"
}

variable "current_account" {
  description = "Which account is currently selected"
  type        = string
  default     = ""
}
# END OVERRIDES ================================================================
# Aws: =========================================================================
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

variable "iam_role_name" {
  description = "Name of the role being created"
  type        = string
  default     = "github_oidc_assume_role"
}

variable "tag_environment" {
  description = "Name of environment"
  type        = string
  default     = ""
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

# Terraform: ===================================================================
variable "framework_prefix" {
  description = "What IaC tool is being used for this deployment?"
  type        = string
  default     = "tf"
}

# Business: ====================================================================
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

# Project: =====================================================================
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "aws_account_setup"
}

variable "environment_abv" {
  description = "Name of environment"
  type        = string
  default     = "brr"
}


