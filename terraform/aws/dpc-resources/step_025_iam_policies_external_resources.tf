locals {
  description = "Custom IAM policy for"
  external_np_policies = [
    {
      name        = "${var.framework_prefix}_${var.project_name}_external_non_prod_service_role_policy"
      description = "${local.description} external non-prod service policy"
      policy      = data.aws_iam_policy_document.tf_external_resource_policy.json
      role        = module.external_non_prod_service_role.created_role.name
    }
  ]
}

# create all policies
module "iam_external_non_prod_policies" {
  providers = {
    aws = aws.brr-np
  }
  source                        = "../modules/iam-policies"                                # Where to find the module
  ######################################################################################################################
  for_each = { for inst in local.external_np_policies : inst.name => inst }
  policy_name                 = each.value.name
  policy_description          = each.value.description
  policy                      = each.value.policy
  policy_role                 = each.value.role
  policy_tags_environment     = var.tag_environment_non_prod
  policy_tags_origination     = var.tag_origination_repo
  policy_tags_project         = var.project_name

  depends_on = [
    module.external_non_prod_service_role
  ]
}

resource "aws_iam_role_policy_attachment" "external_non_prod_service_role_attachment" {
  provider   = aws.brr-np
  role       = module.external_non_prod_service_role.created_role.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"

  depends_on = [
    module.external_non_prod_service_role
  ]
}

# locals {
#   description = "Custom IAM policy for"
#   external_p_policies = [
#     {
#       name        = "tf_${var.project_name}_external_prod_service_role_policy"
#       description = "${local.description} external prod service policy"
#       policy      = data.aws_iam_policy_document.tf_external_resource_policy.json
#       role        = module.np_external_service_role.created_role.name
#     }
#   ]
# }
#
# # create all policies
# module "iam_external_prod_policies" {
#   providers = {
#     aws = aws.brr-p
#   }
#   source                        = "../modules/iam-policies"                                # Where to find the module
#   ######################################################################################################################
#   for_each = { for inst in local.external_p_policies : inst.name => inst }
#   policy_name                 = each.value.name
#   policy_description          = each.value.description
#   policy                      = each.value.policy
#   policy_role                 = each.value.role
#   policy_tags_environment     = var.tag_environment_non_prod
#   policy_tags_origination     = var.tag_origination_repo
#
#   depends_on = [
#     module.external_prod_service_role
#   ]
# }
#
# resource "aws_iam_role_policy_attachment" "external_prod_service_role_attachment" {
#   provider   = aws.brr-np
#   role       = module.np_external_service_role.created_role.name
#   policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
#
#   depends_on = [
#     module.np_external_service_role
#   ]
# }