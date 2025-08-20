# Create a random value to add to the S3 bucket to guarantee uniqueness
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false # Exclude uppercase characters
  # numeric = false # Exclude numeric characters
}

# Create an IAM role to be assumed by GitHub Action
module "github_oidc_assume_role" {
  source = "../../modules/iam-roles" # Where to find the module
  ######################################################################################################################   # Value passed in via variables.tf
  iam_role_name          = var.iam_role_name
  iam_role_description   = "This is the base role that will be assumed"
  iam_assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
  iam_tags_environment   = var.tag_environment
  iam_tags_origination   = var.tag_origination_repo
  iam_tags_project       = var.project_name
}

# Attach IAM Policy to newly created role
resource "aws_iam_role_policy_attachment" "github_oidc_assume_role_attachment" {
  role       = module.github_oidc_assume_role.created_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

  depends_on = [
    module.github_oidc_assume_role
  ]
}

# Create S3 bucket to hold all Terraform state (tfstate) files
module "s3_tf_state_bucket" {
  source = "../../modules/s3" # Where to find the module
  ######################################################################################################################
  create_bucket_name  = "${var.business_area_name}-${var.team_name}-${var.framework_prefix}-state-${random_string.suffix.result}"
  s3_tags_environment = var.tag_environment # Value passed in via variables.tf
  s3_tags_origination = var.tag_origination_repo
  s3_tags_project     = var.project_name
}

# Enable versioning on bucket that maintains terraform state for added protection
resource "aws_s3_bucket_versioning" "aws_tools_versioning_tf_state" {
  bucket = module.s3_tf_state_bucket.aws_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Store created bucket name as a property for reference for other GitHub actions or other future processes
module "s3_tf_state_bucket_property_name" {
  source = "../../modules/ssm" # Where to find the module
  ######################################################################################################################
  property_name             = "${var.framework_prefix}_${var.environment_abv}_tfstate_bucket_name" # Custom defined value
  property_description      = "Deployment bucket created by "                                      # Custom defined value
  property_value            = module.s3_tf_state_bucket.aws_s3_bucket_name                         # Value retrieved from module outputs.tf
  property_tags_environment = var.tag_environment                                                  # Value passed in via variables.tf
  property_tags_origination = var.tag_origination_repo
  property_tags_project     = var.project_name
}

# Add the created role name as a GitHub secret for reference in GitHub actions
resource "github_actions_secret" "action_secret" {
  repository      = var.git_repo_name
  secret_name     = "${var.current_account}_ROLE"
  plaintext_value = module.github_oidc_assume_role.created_role_arn
}