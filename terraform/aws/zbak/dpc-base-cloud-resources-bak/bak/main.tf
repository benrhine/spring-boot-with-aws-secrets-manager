resource "aws_iam_openid_connect_provider" "tools_github" {
  provider = aws.brr-tools
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]
  # GitHub OIDC root CA thumbprint - second value may be unnecessary
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
}
#
# resource "aws_iam_openid_connect_provider" "np_github" {
#   provider = aws.brr-np
#   url = "https://token.actions.githubusercontent.com"
#
#   client_id_list = [
#     "sts.amazonaws.com",
#   ]
#   # GitHub OIDC root CA thumbprint - second value may be unnecessary
#   thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
# }

resource "random_string" "tools_suffix" {
  length  = 8
  special = false
  upper   = false # Exclude uppercase characters
  # numeric = false # Exclude numeric characters
}

resource "random_string" "np_suffix" {
  length  = 8
  special = false
  upper   = false # Exclude uppercase characters
  # numeric = false # Exclude numeric characters
}

resource "random_string" "prod_suffix" {
  length  = 8
  special = false
  upper   = false # Exclude uppercase characters
  # numeric = false # Exclude numeric characters
}

# https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/
# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider.html


module "aws_tools_github_oidc_assume_role" {
  providers = {
    aws = aws.brr-tools
  }
  source = "../../../modules/iam-roles" # Where to find the module
  ######################################################################################################################   # Value passed in via variables.tf
  iam_role_name          = "github_oidc_assume_role"
  iam_role_description   = "This is the base role that will be assumed"
  iam_assume_role_policy = data.aws_iam_policy_document.tools_github_oidc_assume_role.json
  iam_tags_environment   = var.tag_environment_tools
  iam_tags_origination   = var.tag_origination_repo
  iam_tags_project       = var.project_name
}

# module "aws_np_github_oidc_assume_role" {
#   providers = {
#     aws = aws.brr-np
#   }
#   source = "../../modules/iam-roles" # Where to find the module
#   ######################################################################################################################   # Value passed in via variables.tf
#   iam_role_name          = "github_oidc_assume_role"
#   iam_role_description   = "This is the base role that will be assumed"
#   iam_assume_role_policy = data.aws_iam_policy_document.np_github_oidc_assume_role.json
#   iam_tags_environment   = var.tag_environment_tools
#   iam_tags_origination   = var.tag_origination_repo
#   iam_tags_project       = var.project_name
# }

resource "aws_iam_role_policy_attachment" "aws_tools_github_oidc_assume_role_attachment" {
  provider   = aws.brr-tools
  role       = module.aws_tools_github_oidc_assume_role.created_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

  depends_on = [
    module.aws_tools_github_oidc_assume_role
  ]
}

# resource "aws_iam_role_policy_attachment" "aws_np_github_oidc_assume_role_attachment" {
#   provider   = aws.brr-np
#   role       = module.aws_np_github_oidc_assume_role.created_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
#
#   depends_on = [
#     module.aws_np_github_oidc_assume_role
#   ]
# }

module "aws_tools_s3_tf_state_bucket" {
  providers = {
    aws = aws.brr-tools
  }
  source = "../../../modules/s3" # Where to find the module
  ######################################################################################################################
  create_bucket_name  = "${var.business_area_name}-${var.team_name}-${var.framework_prefix}-state-${random_string.tools_suffix.result}"
  s3_tags_environment = var.tag_environment_tools # Value passed in via variables.tf
  s3_tags_origination = var.tag_origination_repo
  s3_tags_project     = var.project_name
}

# Enable versioning on bucket that maintains terraform state
resource "aws_s3_bucket_versioning" "aws_tools_versioning_tf_state" {
  bucket = module.aws_tools_s3_tf_state_bucket.aws_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# module "aws_np_s3_tf_state_bucket" {
#   providers = {
#     aws = aws.brr-np
#   }
#   source = "../../modules/s3" # Where to find the module
#   ######################################################################################################################
#   create_bucket_name  = "${var.business_area_name}-${var.team_name}-${var.framework_prefix}-state-${random_string.np_suffix.result}"
#   s3_tags_environment = var.tag_environment_tools # Value passed in via variables.tf
#   s3_tags_origination = var.tag_origination_repo
#   s3_tags_project     = var.project_name
# }
#
# # Enable versioning on bucket that maintains terraform state
# resource "aws_s3_bucket_versioning" "aws_np_versioning_tf_state" {
#   bucket = module.aws_np_s3_tf_state_bucket.aws_s3_bucket.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

module "aws_tools_s3_tf_state_bucket_property_name" {
  providers = {
    aws = aws.brr-tools
  }
  source = "../../../modules/ssm" # Where to find the module
  ######################################################################################################################
  property_name             = "${var.framework_prefix}_${var.environment_abv}_tools_tfstate_bucket_name" # Custom defined value
  property_description      = "Deployment bucket created by "                                            # Custom defined value
  property_value            = module.aws_tools_s3_tf_state_bucket.aws_s3_bucket_name                               # Value retrieved from module outputs.tf
  property_tags_environment = var.tag_environment_tools                                                  # Value passed in via variables.tf
  property_tags_origination = var.tag_origination_repo
  property_tags_project     = var.project_name
}

# module "aws_np_s3_tf_state_bucket_property_name" {
#   providers = {
#     aws = aws.brr-np
#   }
#   source = "../../modules/ssm" # Where to find the module
#   ######################################################################################################################
#   property_name             = "${var.framework_prefix}_${var.environment_abv}_tools_tfstate_bucket_name" # Custom defined value
#   property_description      = "Deployment bucket created by "                                            # Custom defined value
#   property_value            = module.aws_tools_s3_tf_state_bucket.aws_s3_bucket_name                               # Value retrieved from module outputs.tf
#   property_tags_environment = var.tag_environment_tools                                                  # Value passed in via variables.tf
#   property_tags_origination = var.tag_origination_repo
#   property_tags_project     = var.project_name
# }