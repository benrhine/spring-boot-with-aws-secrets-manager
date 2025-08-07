########################################################################################################################
# IAM Policies Module Declaration: This module is used to define all Aws IAM role policies.
########################################################################################################################
# module "iam_policies" {
#   source                        = "../modules/iam-policies"                                # Where to find the module
#   ######################################################################################################################
#   for_each = { for inst in var.iam_policy_objects_to_create : inst.name => inst }
#   policy_name                 = each.value.name
#   policy_description          = each.value.description
#   policy                      = each.value.policy
# }


locals {
  #   type = list(object({
  #     name        = string
  #     description = string
  #     policy      = string
  #   }))

  #   validation {
  #     condition = alltrue([for x in var.iam_policy_objects_to_create : can(regex("^(tf.brr.)", x.name))])
  #     error_message = "Property name must start with 'tf.brr'."
  #   }

  policies = [
    # Base Assumed Role
    {
      name        = "${var.framework_prefix}_${var.project_name}_iam"
      description = "Custom IAM policy for base role"
      policy      = data.aws_iam_policy_document.tf_account_resources_iam.json
      role        = module.base_assumed_service_role.created_role.name
    },
    # Base Role
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_iam_all"
    #   description = "Custom IAM policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_iam_all.json
    #   role        = module.base_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_codebuild_simple"
    #   description = "Custom CodeBuild policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_codebuild_resource_simple.json
    #   role        = module.base_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_general_codepipeline"
    #   description = "Custom CodePipeline policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_codepipeline.json
    #   role        = module.base_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_ssm"
    #   description = "Custom SSM policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_ssm.json
    #   role        = module.base_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_assume_role_for_${module.base_service_role.created_role.name}"
    #   description = "Custom assume policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_assume_role.json
    #   role        = module.base_service_role.created_role.name
    # },
    # # CodeBuild Role
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_log"
    #   description = "Custom IAM policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_log.json
    #   role        = module.codebuild_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_log_group_build"
    #   description = "Custom CodeBuild policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_log_group_build.json
    #   role        = module.codebuild_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_general_s3"
    #   description = "Custom CodePipeline policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_s3.json
    #   role        = module.codebuild_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_codecommit_repo"
    #   description = "Custom CodeCommit policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_codecommit_repo.json
    #   role        = module.codebuild_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_codebuild"
    #   description = "Custom assume policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_codebuild.json
    #   role        = module.codebuild_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_codepipeline"
    #   description = "Custom IAM policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_codepipeline_simple.json
    #   role        = module.codebuild_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_iam_pass_through"
    #   description = "Custom CodeBuild policy for base rol"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_iam_pass_through.json
    #   role        = module.codebuild_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_ssm_all"
    #   description = "Custom SSM GET policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_ssm_all.json
    #   role        = module.codebuild_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_assume_role_for_${module.codebuild_service_role.created_role.name}"
    #   description = "Custom assume policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_assume_role.json
    #   role        = module.codebuild_service_role.created_role.name
    # },
    # # NOTE AWS SEEMS TO ONLY ALLOW 10 POLICIES PER ROLE WITH OUT REQUESTING AN INCREASE
    # # Grants CloudFormation permission to run from CodeBuild - probably not necessary when using Terraform
    # # {
    # #   name        = "${var.framework_prefix}_${var.project_name}_cloudformation"
    # #   description = "Custom assume policy for base role"
    # #   policy      = data.aws_iam_policy_document.tf_account_resources_cloudformation.json
    # #   role        = module.codebuild_service_role.created_role.name
    # # },
    # # Grants permission to connect to GitHub
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_code_connections"
    #   description = "Custom assume policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_code_connections.json
    #   role        = module.codebuild_service_role.created_role.name
    # },
    # # CodePipeline
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_everything"
    #   description = "Custom everything policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_everything.json
    #   role        = module.codepipeline_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_s3"
    #   description = "Custom assume policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_s3_restricted.json
    #   role        = module.codepipeline_service_role.created_role.name
    # },
    # {
    #   name        = "${var.framework_prefix}_${var.project_name}_assume_role_for_${module.codepipeline_service_role.created_role.name}"
    #   description = "Custom assume policy for base role"
    #   policy      = data.aws_iam_policy_document.tf_account_resources_assume_role.json
    #   role        = module.codepipeline_service_role.created_role.name
    # },
    # Event Rule - disabled as im not currently creating the pipeline
    #     {
    #       name        = "${var.framework_prefix}_${var.project_name}_pipeline_execution"
    #       description = "Custom assume policy for base role"
    #       policy      = data.aws_iam_policy_document.tf_domain_resources_pipeline_execution_policy.json
    #       role        = module.codepipeline_event_rule_role.created_role.name
    #     },

  ]
}

# create all policies
module "iam_policies" {
  # providers = {
  #   aws = aws.brr-tools
  # }
  source = "../../modules/iam-policies" # Where to find the module
  ######################################################################################################################
  for_each                = { for inst in local.policies : inst.name => inst }
  policy_name             = each.value.name
  policy_description      = each.value.description
  policy                  = each.value.policy
  policy_role             = each.value.role
  policy_tags_environment = var.tag_environment_tools
  policy_tags_origination = var.tag_origination_repo
  policy_tags_project     = var.project_name

  depends_on = [
    module.base_assumed_service_role
  ]
}


resource "aws_iam_role_policy_attachment" "base_assumed_service_role_attachment" {
  role       = module.base_assumed_service_role.created_role.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"

  depends_on = [
    module.base_assumed_service_role
  ]
}

