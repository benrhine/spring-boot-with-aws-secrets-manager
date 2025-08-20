# module "aws_tools_github_oidc_assume_role" {
#   source = "../modules/iam-roles" # Where to find the module
#   ######################################################################################################################   # Value passed in via variables.tf
#   iam_role_name          = "github_oidc_assume_role"
#   iam_role_description   = "This is the base role that will be assumed"
#   iam_assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
#   iam_tags_environment   = var.tag_environment_tools
#   iam_tags_origination   = var.tag_origination_repo
#   iam_tags_project       = var.project_name
# }
#
# resource "aws_iam_role_policy_attachment" "external_tools_service_role_attachment" {
#   role       = module.aws_tools_github_oidc_assume_role.created_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
#
#   depends_on = [
#     module.aws_tools_github_oidc_assume_role
#   ]
# }

module "base_assumed_service_role" {
  providers = {
    aws = aws.brr-tools
  }
  source = "../../../modules/iam-roles" # Where to find the module
  ######################################################################################################################   # Value passed in via variables.tf
  iam_role_name          = "${var.framework_prefix}_base_assumed_service_role"
  iam_role_description   = "This is the base role that will be assumed"
  iam_assume_role_policy = data.aws_iam_policy_document.base_assumed_role_trust_relationship.json
  iam_tags_environment   = var.tag_environment_tools
  iam_tags_origination   = var.tag_origination_repo
  iam_tags_project       = var.project_name
}