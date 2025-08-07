resource "aws_iam_policy" "policy" {
  name          = var.policy_name
  description   = var.policy_description
  policy        = var.policy
  tags = {
    environment = var.policy_tags_environment
    origination = var.policy_tags_origination
  }
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role          = var.policy_role
  policy_arn    = aws_iam_policy.policy.arn
}
