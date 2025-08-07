
resource "aws_codepipeline" "codepipeline" {
  name     = var.pipeline_name
  role_arn = var.service_role_arn

  artifact_store {
    location = var.deployment_bucket
    type     = var.artifact_store_type
  }

  stage {
    name = var.stage_1_name

    action {
      name             = var.stage_1_action_name
      category         = var.stage_1_action_category
      owner            = var.stage_1_action_owner
      provider         = var.stage_1_action_provider
      version          = var.stage_1_action_version
      output_artifacts = var.stage_1_action_output_artifacts
      namespace        = var.stage_1_action_namespace

      configuration = {
        OutputArtifactFormat = var.stage_1_action_configuration_output_artifact_format
        PollForSourceChanges = var.stage_1_action_configuration_poll_for_source_changes
        RepositoryName = var.git_repo_name
        BranchName       = var.stage_1_action_configuration_branch_name
      }
    }
  }

  stage {
    name = "replicate-to-alternate-region"

    action {
      name             = "replicate"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project
      }
    }
  }

#   stage {
#     name = "Deploy"
#
#     action {
#       name            = "Deploy"
#       category        = "Deploy"
#       owner           = "AWS"
#       provider        = "CloudFormation"
#       input_artifacts = ["build_output"]
#       version         = "1"
#
#       configuration = {
#         ActionMode     = "REPLACE_ON_FAILURE"
#         Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
#         OutputFileName = "CreateStackOutput.json"
#         StackName      = "MyStack"
#         TemplatePath   = "build_output::sam-templated.yaml"
#       }
#     }
#   }

  tags = {
    environment = var.pipeline_tags_environment
    origination = var.pipeline_tags_origination
  }
}

# resource "aws_codestarconnections_connection" "example" {
#   name          = "example-connection"
#   provider_type = "GitHub"
# }

# resource "aws_s3_bucket" "codepipeline_bucket" {
#   bucket = "test-bucket"
# }

# resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_pab" {
#   bucket = aws_s3_bucket.codepipeline_bucket.id
#
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"
#
#     principals {
#       type        = "Service"
#       identifiers = ["codepipeline.amazonaws.com"]
#     }
#
#     actions = ["sts:AssumeRole"]
#   }
# }
#
# resource "aws_iam_role" "codepipeline_role" {
#   name               = "test-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }
#
# data "aws_iam_policy_document" "codepipeline_policy" {
#   statement {
#     effect = "Allow"
#
#     actions = [
#       "s3:GetObject",
#       "s3:GetObjectVersion",
#       "s3:GetBucketVersioning",
#       "s3:PutObjectAcl",
#       "s3:PutObject",
#     ]
#
#     resources = [
#       aws_s3_bucket.codepipeline_bucket.arn,
#       "${aws_s3_bucket.codepipeline_bucket.arn}/*"
#     ]
#   }
#
#   statement {
#     effect    = "Allow"
#     actions   = ["codestar-connections:UseConnection"]
#     resources = [aws_codestarconnections_connection.example.arn]
#   }
#
#   statement {
#     effect = "Allow"
#
#     actions = [
#       "codebuild:BatchGetBuilds",
#       "codebuild:StartBuild",
#     ]
#
#     resources = ["*"]
#   }
# }
#
# resource "aws_iam_role_policy" "codepipeline_policy" {
#   name   = "codepipeline_policy"
#   role   = aws_iam_role.codepipeline_role.id
#   policy = data.aws_iam_policy_document.codepipeline_policy.json
# }

# data "aws_kms_alias" "s3kmskey" {
#   name = "alias/myKmsKey"
# }