
# resource "aws_iam_role_policy_attachment" "created_role" {
#   role       = var.role
#   policy_arn = var.policy_arn
# }

resource "aws_iam_role_policy_attachment" "created_role" {
  role       = var.role
  policy_arn = var.policy_arn
}

# resource "aws_iam_role_policy_attachment" "created_role" {
#   role       = var.role
#   for_each = toset(var.policies)
#   policy_arn     = each.value
# }


# resource "aws_iam_role_policy_attachment" "base_assumed_service_role_1" {
#   role       = var.base_assumed_service_role.name
#   policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
# }

# 3.0 Create custom policy data in modules/iam-policies/data.tf via importing the module
# 3.1 Make data available as resource in modules/iam-policies/main.tf
# 3.2 Make created data available via modules/iam-policies/outputs.tf

# 4. Attache custom policy to role created in step 1.
# resource "aws_iam_role_policy_attachment" "base_assumed_service_role_2" {
#   role       = var.base_assumed_service_role.name
# #   policy_arn = var.iam_policies_module.tf_resource_iam_policy_arn
# #   policy_arn = var.iam_policies_module.created_iam_policies
# #   policy_arn = [for policy in var.iam_policies_module.created_iam_policies : policy.name == "tf_resource_iam_policy" ? policy : ""]
#   for_each    = { for policy in var.iam_policies_module.created_iam_policies : policy => inst}
#   policy_arn  = each.value.name == "tf_resource_iam_policy_arn" ? each.value : ""
# }

//----

# resource "aws_iam_role_policy_attachment" "base_service_role_1" {
#   role       = var.base_service_role.name
#   policy_arn = var.iam_policies_module.tf_resource_iam_policy_all_arn
# }
#
# resource "aws_iam_role_policy_attachment" "base_service_role_2" {
#   role       = var.base_service_role.name
#   policy_arn = var.iam_policies_module.tf_codebuild_resource_simple_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "base_service_role_3" {
#   role       = var.base_service_role.name
#   policy_arn = var.iam_policies_module.tf_codepipeline_resource_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "base_service_role_4" {
#   role       = var.base_service_role.name
#   policy_arn = var.iam_policies_module.tf_ssm_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "base_service_role_5" {
#   role       = var.base_service_role.name
#   policy_arn = var.iam_policies_module.tf_assume_role_policy_arn
# }
#
# //---
#
# resource "aws_iam_role_policy_attachment" "codebuild_service_role_1" {
#   role       = var.codebuild_service_role.name
#   policy_arn = var.iam_policies_module.tf_log_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "codebuild_service_role_2" {
#   role       = var.codebuild_service_role.name
#   policy_arn = var.iam_policies_module.tf_log_group_build_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "codebuild_service_role_3" {
#   role       = var.codebuild_service_role.name
#   policy_arn = var.iam_policies_module.tf_s3_resource_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "codebuild_service_role_4" {
#   role       = var.codebuild_service_role.name
#   policy_arn = var.iam_policies_module.tf_codecommit_resource_repo_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "codebuild_service_role_5" {
#   role       = var.codebuild_service_role.name
#   policy_arn = var.iam_policies_module.tf_codebuild_resource_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "codebuild_service_role_6" {
#   role       = var.codebuild_service_role.name
#   policy_arn = var.iam_policies_module.tf_domain_resources_codepipeline_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "codebuild_service_role_7" {
#   role       = var.codebuild_service_role.name
#   policy_arn = var.iam_policies_module.tf_resource_iam_pass_through_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "codebuild_service_role_8" {
#   role       = var.codebuild_service_role.name
#   policy_arn = var.iam_policies_module.tf_ssm_get_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "codebuild_service_role_9" {
#   role       = var.codebuild_service_role.name
#   policy_arn = var.iam_policies_module.tf_assume_role_policy_arn
# }
#
# //----
#
# resource "aws_iam_role_policy_attachment" "codepipeline_service_role_1" {
#   role       = var.codepipeline_service_role.name
#   policy_arn = var.iam_policies_module.tf_domain_resources_everything_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "codepipeline_service_role_2" {
#   role       = var.codepipeline_service_role.name
#   policy_arn = var.iam_policies_module.tf_domain_resources_s3_resource_policy_arn
# }
#
# resource "aws_iam_role_policy_attachment" "codepipeline_service_role_3" {
#   role       = var.codepipeline_service_role.name
#   policy_arn = var.iam_policies_module.tf_assume_role_policy_arn
# }
#
# //----
#
#
# resource "aws_iam_role_policy_attachment" "codepipeline_event_rule_role_1" {
#   role       = var.codepipeline_event_rule_role.name
#   policy_arn = var.iam_policies_module.tf_domain_resources_pipeline_execution_policy_arn
# }
