data "aws_iam_policy_document" "base_assumed_role_trust_relationship" {
  statement {
    actions   = [
      "sts:AssumeRole"
    ]
    principals {
      # Note that in CF and SLS i have this set to the PROD account not non-prod
      identifiers = ["arn:aws:iam::${var.account_non_prod}:root"]
      type = "AWS"
    }
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "codepipeline_event_rule_role_trust_relationship" {
  statement {
    actions   = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = ["events.amazonaws.com"]
      type = "Service"
    }
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "base_role_trust_relationship" {
  statement {
    actions   = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "codepipeline.amazonaws.com",
        "codebuild.amazonaws.com",
        "cloudformation.amazonaws.com"
      ]
      type = "Service"
    }
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "codebuild_role_trust_relationship" {
  statement {
    actions   = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "codebuild.amazonaws.com"
      ]
      type = "Service"
    }
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "codepipeline_role_trust_relationship" {
  statement {
    actions   = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "codepipeline.amazonaws.com"
      ]
      type = "Service"
    }
    effect = "Allow"
  }
}
