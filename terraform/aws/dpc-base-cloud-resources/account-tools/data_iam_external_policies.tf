data "aws_iam_policy_document" "tf_external_resource_policy" {
  statement {
    actions = [
      "acm:DescribeCertificate",
      "acm:DeleteCertificate",
      "acm:ListCertificates",
      "acm:GetCertificate",
      "acm:ListTagsForCertificate",
      "acm:GetAccountConfiguration",
      "acm:RequestCertificate",
      "route53:ListHostedZones",
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
      "apigateway:GET",
      "apigateway:POST",
      "apigateway:PUT",
      "apigateway:DELETE",
      "apigateway:*",
      "iam:*",
      "s3:*",
      "sqs:*",
      "cloudformation:CreateStack",
      "cloudformation:DescribeStacks",
      "cloudformation:DeleteStack",
      "cloudformation:CreateChangeSet",
      "cloudformation:DescribeChangeSet",
      "cloudformation:DeleteChangeSet",
      "cloudformation:ExecuteChangeSet",
      "cloudformation:DescribeStackEvents",
      "cloudformation:ListStacks",
      "cloudformation:ListStackResources",
      "cloudformation:UpdateStack",
      "cloudformation:ValidateTemplate",
      "lambda:*",
      "logs:*"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
}