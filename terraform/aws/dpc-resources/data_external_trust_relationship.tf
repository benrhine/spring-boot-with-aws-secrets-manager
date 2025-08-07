# additions to identifiers must be added as , new item. identifiers does not want to take variable list,
# Tried to figure out if this could take a parameter so that it could be set external and yes it can be set by a parameter
# it will not take a list. Also the role will not be updated if the parameter changes.
# For this reason it has been decided that it is best to define the trust user here and add any future updates to this
# location
data "aws_iam_policy_document" "external_role_trust_relationship" {
  statement {
    actions   = [
      "sts:AssumeRole"
    ]
    principals {
      # identifiers MUST be declared with []
      identifiers = [
        module.base_assumed_service_role.created_role.arn
      ]
      type = "AWS"
    }
    effect = "Allow"
  }

  depends_on = [
    module.base_assumed_service_role
  ]
}