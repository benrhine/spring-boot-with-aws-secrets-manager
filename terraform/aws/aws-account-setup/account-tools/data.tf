# THESE CALLS ARE PULLING THE DATA FROM THE LOCALLY LOGGED IN ACCOUNT - I.E. IF YOU ARE LOGGED INTO US-WEST-2 IT WILL
# RETURN US-WEST-2

# Retrieve the current aws account
data "aws_caller_identity" "current" {}

# Retrieve the current aws region
data "aws_region" "current" {}


data "aws_iam_policy_document" "tf_account_resources_s3" {
  statement {
    actions = [
      "s3:*"
      # "s3:PutObject",
      # "s3:GetObject",
      # "s3:GetObjectVersion",
      # "s3:GetBucketAcl",
      # "s3:GetBucketLocation",
      # "s3:PutAccelerateConfiguration"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "tf_account_resources_iam_all" {
  statement {
    actions = [
      "iam:AttachRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:PassRole",
      "iam:CreateRole",
      "iam:CreatePolicy",
      "iam:GetRole",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:DeleteRole",
      "iam:DeletePolicy",
      "iam:DeleteRolePolicy",
      "iam:DetachRole",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:TagRole",
      "iam:TagPolicy",
      "iam:ListRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:ListPolicyVersions",
      "secretsmanager:GetSecretValue",
      "ssm:GetParametersByPath",
      "ssm:GetParameter"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}
