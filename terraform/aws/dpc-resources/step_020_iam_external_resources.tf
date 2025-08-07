# create role to assume on brr-np
module "external_non_prod_service_role" {
  providers = {
    aws = aws.brr-np
  }
  source = "../modules/iam-roles" # Where to find the module
  ######################################################################################################################   # Value passed in via variables.tf
  iam_role_name          = "${var.framework_prefix}_${var.project_name}_external_non_prod_service_role"
  iam_role_description   = "External role to be assumed at deployment time"
  iam_assume_role_policy = data.aws_iam_policy_document.external_role_trust_relationship.json
  iam_tags_environment   = var.tag_environment_non_prod
  iam_tags_origination   = var.tag_origination_repo
  iam_tags_project       = var.project_name

  depends_on = [
    module.base_assumed_service_role
  ]
}


# create role to assume on brr-p
# module "external_prod_service_role" {
#   providers = {
#     aws = aws.brr-p
#   }
#   source                        = "../modules/iam-roles"                                   # Where to find the module
#   ######################################################################################################################   # Value passed in via variables.tf
#   iam_role_name                 = "${var.framework_prefix}_${var.project_name}_external_prod_service_role"
#   iam_role_description          = "External role to be assumed at deployment time"
#   iam_assume_role_policy        = data.aws_iam_policy_document.external_role_trust_relationship.json
#   iam_tags_environment          = var.tag_environment_prod
#   iam_tags_origination          = var.tag_origination_repo
#
#   depends_on = [
#     module.ssm_3
#   ]
# }