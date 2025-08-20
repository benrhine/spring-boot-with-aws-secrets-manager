resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]
  # GitHub OIDC root CA thumbprint - second value may be unnecessary
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false # Exclude uppercase characters
  # numeric = false # Exclude numeric characters
}

# arn:aws:iam::792981815698:oidc-provider/token.actions.githubusercontent.com


# https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/
# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider.html


module "aws_tools_github_oidc_assume_role" {
  source                        = "../../modules/iam-roles"                                   # Where to find the module
  ######################################################################################################################   # Value passed in via variables.tf
  iam_role_name                 = "github_oidc_assume_role"
  iam_role_description          = "This is the base role that will be assumed"
  iam_assume_role_policy        = data.aws_iam_policy_document.github_oidc_assume_role.json
  iam_tags_environment          = "test"
  iam_tags_origination          = "test"
  iam_tags_project              = "test"
}

# module "aws_np_github_oidc_assume_role" {
#   providers = {
#     aws = aws.brr-np
#   }
#   source                        = "../modules/iam-roles"                                   # Where to find the module
#   ######################################################################################################################   # Value passed in via variables.tf
#   iam_role_name                 = "github_oidc_assume_role"
#   iam_role_description          = "This is the base role that will be assumed"
#   iam_assume_role_policy        = data.aws_iam_policy_document.github_oidc_assume_role.json
#   iam_tags_environment          = "test"
#   iam_tags_origination          = "test"
#   iam_tags_project              = "test"
# }

resource "aws_iam_role_policy_attachment" "external_tools_service_role_attachment" {
  # provider   = aws.brr-tools
  role       = module.aws_tools_github_oidc_assume_role.created_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

  depends_on = [
    module.aws_tools_github_oidc_assume_role
  ]
}

# resource "aws_iam_role_policy_attachment" "external_non_prod_service_role_attachment" {
#   provider   = aws.brr-np
#   role       = module.aws_np_github_oidc_assume_role.created_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
#
#   depends_on = [
#     module.aws_np_github_oidc_assume_role
#   ]
# }

# ids-dpc-terraform-state

module "s3" {
  source                        = "../../modules/s3"                                          # Where to find the module
  ######################################################################################################################
  #   aws_region                    = data.aws_region.current.name                            # Value retrieved in data.tf
  #   aws_account                   = data.aws_caller_identity.current.account_id             # Value retrieved in data.tf
  #   project_name                  = var.project_name                                        # Value passed in via variables.tf
  # Custom defined value
  create_bucket_name            = "ids-dpc-terraform-state-${random_string.suffix.result}"
  s3_tags_environment           = "test"                                 # Value passed in via variables.tf
  s3_tags_origination           = "test"
  s3_tags_project               = "test"
}

# Enable versioning on bucket that maintains terraform state
resource "aws_s3_bucket_versioning" "versioning_tf_state" {
  bucket = module.s3.aws_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform-lock-table" {
  name         = "terraform-lock-table-${random_string.suffix.result}"
  billing_mode = "PROVISIONED" # Or "PAY_PER_REQUEST" for on-demand
  read_capacity  = 5           # Required for PROVISIONED mode
  write_capacity = 5           # Required for PROVISIONED mode
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  # Optional: Add a range key if needed
  # range_key = "OrderID"
  # attribute {
  #   name = "OrderID"
  #   type = "N"
  # }

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}



# locals {
#   #   type = list(object({
#   #     name        = string
#   #     description = string
#   #     policy      = string
#   #   }))
#
#   #   validation {
#   #     condition = alltrue([for x in var.iam_policy_objects_to_create : can(regex("^(tf.brr.)", x.name))])
#   #     error_message = "Property name must start with 'tf.brr'."
#   #   }
#
#   policies = [
#     # Base Assumed Role
#     {
#       name        = "tf_account_resources_s3"
#       description = "Custom IAM policy for base role"
#       policy      = data.aws_iam_policy_document.tf_account_resources_s3.json
#       role        = module.aws_tools_github_oidc_assume_role.created_role.name
#     },
#     # Base Role
#     {
#       name        = "tf_account_resources_iam_all"
#       description = "Custom IAM policy for base role"
#       policy      = data.aws_iam_policy_document.tf_account_resources_iam_all.json
#       role        = module.aws_tools_github_oidc_assume_role.created_role.name
#     },
#     {
#       name        = "tf_np_account_resources_s3"
#       description = "Custom IAM policy for base role"
#       policy      = data.aws_iam_policy_document.tf_account_resources_s3.json
#       role        = module.aws_np_github_oidc_assume_role.created_role.name
#     },
#     # Base Role
#     # {
#     #   name        = "tf_np_account_resources_iam_all"
#     #   description = "Custom IAM policy for base role"
#     #   policy      = data.aws_iam_policy_document.tf_account_resources_iam_all.json
#     #   role        = module.aws_np_github_oidc_assume_role.created_role.name
#     # },
#     # {
#     #   name        = "${var.framework_prefix}_${var.project_name}_codebuild_simple"
#     #   description = "Custom CodeBuild policy for base role"
#     #   policy      = data.aws_iam_policy_document.tf_account_resources_codebuild_resource_simple.json
#     #   role        = module.base_service_role.created_role.name
#     # },
#     # {
#     #   name        = "${var.framework_prefix}_${var.project_name}_general_codepipeline"
#     #   description = "Custom CodePipeline policy for base role"
#     #   policy      = data.aws_iam_policy_document.tf_account_resources_codepipeline.json
#     #   role        = module.base_service_role.created_role.name
#     # },
#     # {
#     #   name        = "${var.framework_prefix}_${var.project_name}_ssm"
#     #   description = "Custom SSM policy for base role"
#     #   policy      = data.aws_iam_policy_document.tf_account_resources_ssm.json
#     #   role        = module.base_service_role.created_role.name
#     # },
#     # {
#     #   name        = "${var.framework_prefix}_${var.project_name}_assume_role_for_${module.base_service_role.created_role.name}"
#     #   description = "Custom assume policy for base role"
#     #   policy      = data.aws_iam_policy_document.tf_account_resources_assume_role.json
#     #   role        = module.base_service_role.created_role.name
#     # }
#   ]
# }
#
# # create all policies
# module "iam_policies" {
#   providers = {
#     aws = aws.brr-tools
#   }
#   source                        = "../modules/iam-policies"                                # Where to find the module
#   ######################################################################################################################
#   for_each = { for inst in local.policies : inst.name => inst }
#   policy_name                 = each.value.name
#   policy_description          = each.value.description
#   policy                      = each.value.policy
#   policy_role                 = each.value.role
#   policy_tags_environment     = "test"
#   policy_tags_origination     = "test"
#   policy_tags_project         = "test"
#
#   # depends_on = [
#   #   module.base_assumed_service_role,
#   #   module.base_service_role,
#   #   module.codebuild_service_role,
#   #   module.codepipeline_service_role,
#   #   module.codepipeline_event_rule_role,
#   #   module.external_non_prod_service_role
#   # ]
# }

module "ssm_1" {
  source                        = "../../modules/ssm"                                          # Where to find the module
  ######################################################################################################################
  property_name                 = "tf.brr.tools.build.s3.bucket.name"  # Custom defined value
  property_description          = "Deployment bucket created by "        # Custom defined value
  property_value                = "brr-tools-test"                            # Value retrieved from module outputs.tf
  property_tags_environment     = "test"                                 # Value passed in via variables.tf
  property_tags_origination     = "test"
  property_tags_project         = "test"
}

# module "ssm_2" {
#   source                        = "../modules/ssm"                                          # Where to find the module
#   ######################################################################################################################
#   property_name                 = "tf.brr.tools.tfstate.bucket.name"  # Custom defined value
#   property_description          = "Deployment bucket created by "        # Custom defined value
#   property_value                = "ids-dpc-terraform-state"                            # Value retrieved from module outputs.tf
#   property_tags_environment     = "test"                                 # Value passed in via variables.tf
#   property_tags_origination     = "test"
#   property_tags_project         = "test"
# }

module "ssm_3" {
  source                        = "../../modules/ssm"                                          # Where to find the module
  ######################################################################################################################
  property_name                 = "tf_brr_tools_tfstate_bucket_name"  # Custom defined value
  property_description          = "Deployment bucket created by "        # Custom defined value
  property_value                = module.s3.aws_s3_bucket_name                            # Value retrieved from module outputs.tf
  property_tags_environment     = "test"                                 # Value passed in via variables.tf
  property_tags_origination     = "test"
  property_tags_project         = "test"
}