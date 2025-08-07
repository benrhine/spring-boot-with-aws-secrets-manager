# # Retrieve the current aws account
# data "aws_caller_identity" "current" {}
#
# # Retrieve the current aws region
# data "aws_region" "current" {}
#
# ########################################################################################################################
# # Declared IAM policy data
# # Each data block is declared as follows `data "RESOURCE-TYPE" "RESOURCE-NAME" {}`
# # Resource-type is defined by terraform, resource-name is user defined (can essentially be anything)
# ########################################################################################################################
# data "aws_iam_policy_document" "tf_resource_iam_policy_all" {
#   statement {
#     actions   = [
#       "iam:AttachRolePolicy",
#       "iam:CreateRole",
#       "iam:GetRole",
#       "iam:PassRole",
#       "iam:DeleteRole",
#       "iam:DeleteRolePolicy",
#       "iam:DetachRolePolicy",
#       "iam:PutRolePolicy"
#     ]
#     resources = ["*"]
#     effect = "Allow"
#   }
# }
#
# data "aws_iam_policy_document" "tf_resource_iam_policy" {
#   statement {
#     actions   = [
#       "iam:AttachRolePolicy",
#       "iam:CreateRole",
#       "iam:GetRole",
#       "iam:PassRole",
#       "iam:DeleteRole",
#       "iam:DeleteRolePolicy",
#       "iam:DetachRolePolicy",
#       "iam:PutRolePolicy"
#     ]
#     resources = ["arn:aws:iam::${var.aws_account}:role/*"]
#     effect = "Allow"
#   }
# }
#
# data "aws_iam_policy_document" "tf_codebuild_resource_simple_policy" { // this one
#   statement {
#     actions   = [
#       "codebuild:CreateProject",
#       "codebuild:UpdateProject",
#       "codebuild:DeleteProject"
#     ]
#     resources = ["*"]
#     effect = "Allow"
#   }
# }
#
# data "aws_iam_policy_document" "tf_codepipeline_resource_policy" {
#   statement {
#     actions   = [
#       "codepipeline:GetPipeline",
#       "codepipeline:CreatePipeline",
#       "codepipeline:UpdatePipeline",
#       "codepipeline:DeletePipeline",
#       "codepipeline:GetPipelineState"
#     ]
#     resources = ["*"]
#     effect = "Allow"
#   }
# }
#
# data "aws_iam_policy_document" "tf_ssm_policy" {
#   statement {
#     actions   = [
#       "ssm:PutParameter",
#       "ssm:DeleteParameter"
#     ]
#     resources = ["arn:aws:ssm:${var.aws_region}:${var.aws_account}:parameter/brr.*"]
#     effect = "Allow"
#   }
# }
#
# # data "aws_iam_role" "create_base_service_role_data" {
# #   arn = var.create_base_assumed_service_role
# # }
#
# data "aws_iam_policy_document" "tf_assume_role_policy" {
#   statement {
#     actions   = [
#       "sts:AssumeRole"
#     ]
#     resources = [var.policy_resource_arn]
#     effect = "Allow"
#   }
# }
#
# #          PolicyDocument:
# #            Version: '2012-10-17'
# #            Statement:
# #              - Effect: Allow
# #                Action:
# #                  - sts:AssumeRole
# #                Resource:
# #                  - !Sub ${BaseAssumedServiceRole.Arn}
#
# data "aws_iam_policy_document" "tf_log_policy" {
#   statement {
#     actions   = [
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#       "logs:PutQueryDefinition",
#       "logs:TagResource"
#     ]
#     resources = ["arn:aws:logs:*:*:*"]
#     effect = "Allow"  # note that these rights are given in the default policy and are required if you want logs out of your lambda(s)
#   }
# }
#
# # Policies:
# #   - PolicyName: cf-log-policy
# #     PolicyDocument:
# #       Version: '2012-10-17'
# #       Statement:
# #         - Effect: Allow # note that these rights are given in the default policy and are required if you want logs out of your lambda(s)
# #           Action:
# #             - logs:CreateLogGroup
# #             - logs:CreateLogStream
# #             - logs:PutLogEvents
# #             - logs:PutQueryDefinition
# #             - logs:TagResource
# #           Resource:
# #             - 'arn:aws:logs:*:*:*'
#
# data "aws_iam_policy_document" "tf_log_group_build_policy" {
#   statement {
#     actions   = [
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#       "logs:PutQueryDefinition",
#       "logs:TagResource"
#     ]
#     resources = [
#       "arn:aws:logs:${var.aws_region}:${var.aws_account}:log-group:/aws/codebuild/tf-*",
#       "arn:aws:logs:${var.aws_region}:${var.aws_account}:log-group:/aws/codebuild/sls-*",
#       "arn:aws:logs:${var.aws_region}:${var.aws_account}:log-group:/aws/codebuild/step-*"
#     ]
#     effect = "Allow"  # note that these rights are given in the default policy and are required if you want logs out of your lambda(s)
#   }
# }
#
# #   - PolicyName: cf-log-group-build-policy
# #          PolicyDocument:
# #            Version: '2012-10-17'
# #            Statement:
# #              - Effect: Allow
# #                Action:
# #                  - logs:CreateLogGroup
# #                  - logs:CreateLogStream
# #                  - logs:PutLogEvents
# #                  - logs:PutQueryDefinition
# #                  - logs:TagResource
# #                Resource:
# #                  - Fn::Join:
# #                      - ':'
# #                      - - 'arn:aws:logs'
# #                        - Ref: 'AWS::Region'
# #                        - Ref: 'AWS::AccountId'
# #                        - log-group:/aws/codebuild/cf-*
# #                  - Fn::Join:
# #                      - ':'
# #                      - - 'arn:aws:logs'
# #                        - Ref: 'AWS::Region'
# #                        - Ref: 'AWS::AccountId'
# #                        - log-group:/aws/codebuild/sls-*
# #                  - Fn::Join:
# #                      - ':'
# #                      - - 'arn:aws:logs'
# #                        - Ref: 'AWS::Region'
# #                        - Ref: 'AWS::AccountId'
# #                        - log-group:/aws/codebuild/step-*
#
# data "aws_iam_policy_document" "tf_s3_resource_policy" {
#   statement {
#     actions   = [
#       "s3:PutObject",
#       "s3:GetObject",
#       "s3:GetObjectVersion",
#       "s3:GetBucketAcl",
#       "s3:GetBucketLocation",
#       "s3:PutAccelerateConfiguration"
#     ]
#     resources = ["*"]
#     effect = "Allow"
#   }
# }
#
# #        - PolicyName: cf-s3-resource-policy
# #          PolicyDocument:
# #            Version: '2012-10-17'
# #            Statement:
# #              - Effect: Allow
# #                Action:
# #                  - s3:PutObject
# #                  - s3:GetObject
# #                  - s3:GetObjectVersion
# #                  - s3:GetBucketAcl
# #                  - s3:GetBucketLocation
# #                  - s3:PutAccelerateConfiguration
# #                Resource:
# #                  - '*'
#
# data "aws_iam_policy_document" "tf_codecommit_resource_repo_policy" {
#   statement {
#     actions   = [
#       "codecommit:GitPull",
#       "codecommit:GitPush"
#     ]
#     resources = ["*"]
#     effect = "Allow"
#   }
# }
#
# #        - PolicyName: cf-codecommit-resource-repo-policy
# #          PolicyDocument:
# #            Version: '2012-10-17'
# #            Statement:
# #              - Effect: Allow
# #                Action:
# #                  - codecommit:GitPull
# #                  - codecommit:GitPush
# #                Resource:
# #                  - '*'
#
# data "aws_iam_policy_document" "tf_codebuild_resource_policy" {
#   statement {
#     actions   = [
#       "codebuild:CreateReportGroup",
#       "codebuild:CreateReport",
#       "codebuild:UpdateReport",
#       "codebuild:BatchPutTestCases",
#       "codebuild:BatchPutCodeCoverages",
#       "codebuild:StartBuild",
#       "codebuild:StopBuild",
#       "codebuild:RetryBuild"
#     ]
#     resources = ["*"]
#     effect = "Allow"
#   }
# }
# #        - PolicyName: cf-codebuild-resource-policy
# #          PolicyDocument:
# #            Version: '2012-10-17'
# #            Statement:
# #              - Effect: Allow
# #                Action:
# #                  - codebuild:CreateReportGroup
# #                  - codebuild:CreateReport
# #                  - codebuild:UpdateReport
# #                  - codebuild:BatchPutTestCases
# #                  - codebuild:BatchPutCodeCoverages
# #                  - codebuild:StartBuild
# #                  - codebuild:StopBuild
# #                  - codebuild:RetryBuild
# #                Resource:
# #                  - '*'
#
# data "aws_iam_policy_document" "tf_domain_resources_codepipeline_policy" {
#   statement {
#     actions   = [
#       "codepipeline:GetPipelineExecution",
#       "codepipeline:StopPipelineExecution",
#       "codepipeline:ListPipelineExecutions"
#     ]
#     resources = ["*"]
#     effect = "Allow"
#   }
# }
# #        - PolicyName: !Sub ${ProjectName}-codepipeline-policy
# #          PolicyDocument:
# #            Version: '2012-10-17'
# #            Statement:
# #              - Effect: Allow
# #                Action:
# #                  - codepipeline:GetPipelineExecution
# #                  - codepipeline:StopPipelineExecution
# #                  - codepipeline:ListPipelineExecutions
# #                Resource:
# #                  - '*'
#
# data "aws_iam_policy_document" "tf_resource_iam_pass_through_policy" {
#   statement {
#     actions   = [
#       "iam:PassRole"
#     ]
#     resources = ["*"]
#     effect = "Allow"
#   }
# }
# #        - PolicyName: cf-resource-iam-policy
# #          PolicyDocument:
# #            Version: '2012-10-17'
# #            Statement:
# #              - Effect: Allow
# #                Action:
# #                  - iam:PassRole
# #                Resource:
# #                  - '*'
#
# data "aws_iam_policy_document" "tf_ssm_get_policy" {
#   statement {
#     actions   = [
#       "ssm:GetParameter",
#       "ssm:GetParameters"
#     ]
#     resources = ["*"]
#     effect = "Allow"
#   }
# }
# #        - PolicyName: cf-ssm-policy
# #          PolicyDocument:
# #            Version: '2012-10-17'
# #            Statement:
# #              - Effect: Allow # note that these rights are given in the default policy and are required if you want logs out of your lambda(s)
# #                Action:
# #                  - ssm:GetParameter
# #                  - ssm:GetParameters
# #                Resource:
# #                  - '*'
#
# data "aws_iam_policy_document" "tf_domain_resources_everything_policy" {
#   statement {
#     actions   = [
#       "codepipeline:GetPipeline",
#       "codepipeline:GetPipelineExecution",
#       "codepipeline:StopPipelineExecution",
#       "codepipeline:ListPipelineExecutions",
#       "codecommit:List*",
#       "codecommit:Get*",
#       "codecommit:GitPull",
#       "codecommit:GitPush",
#       "codecommit:UploadArchive",
#       "codecommit:CancelUploadArchive",
#       "codebuild:BatchGetBuilds",
#       "codebuild:BatchGetBuildBatches",
#       "codebuild:StartBuild",
#       "codebuild:StartBuildBatch",
#       "iam:PassRole",
#       "sns:Publish",
#       "ec2:DescribeSecurityGroups",
#       "cloudformation:*",
#       "codedeploy:*",
#       "cloudwatch:*",
#       "ecs:*",
#       "lambda:InvokeFunction",
#       "lambda:ListFunctions",
#       "codestar-connections:UseConnection",
#       "ecr:DescribeImages",
#       "kms:Decrypt"
#     ]
#     resources = ["*"]
#     effect = "Allow"
#   }
# }
#
#
# #   Policies:
# #        - PolicyName: !Sub ${ProjectName}-everything-policy
# #          PolicyDocument:
# #            Version: 2012-10-17
# #            Statement:
# #              - Effect: Allow
# #                Action:
# #                  - codepipeline:GetPipeline
# #                  - codepipeline:GetPipelineExecution
# #                  - codepipeline:StopPipelineExecution
# #                  - codepipeline:ListPipelineExecutions
# #                  - codecommit:List*
# #                  - codecommit:Get*
# #                  - codecommit:GitPull
# #                  - codecommit:GitPush
# #                  - codecommit:UploadArchive
# #                  - codecommit:CancelUploadArchive
# #                  - codebuild:BatchGetBuilds
# #                  - codebuild:BatchGetBuildBatches
# #                  - codebuild:StartBuild
# #                  - codebuild:StartBuildBatch
# #                  - iam:PassRole
# #                  - sns:Publish
# #                  - ec2:DescribeSecurityGroups
# #                  - cloudformation:*
# #                  - codedeploy:*
# #                  - cloudwatch:*
# #                  - ecs:*
# #                  - lambda:InvokeFunction
# #                  - lambda:ListFunctions
# #                  - codestar-connections:UseConnection
# #                  - ecr:DescribeImages
# #                Resource:
# #                  - "*"
# #              - Effect: Allow
# #                Action:
# #                  - kms:Decrypt
# #                Resource: "*"
# #              - Effect: Allow
# #                Action:
# #                  - s3:PutObject
# #                  - s3:GetBucketPolicy
# #                  - s3:GetObject
# #                  - s3:ListBucket
# #                  - s3:ListAllMyBuckets
# #                  - s3:GetBucketLocation
# #                Resource:
# #                  - !Sub arn:aws:s3:::${AccountName}-${AWS::Region}-${S3DeploymentBucket}
# #                  - !Sub arn:aws:s3:::${AccountName}-${AWS::Region}-${S3DeploymentBucket}/*
# #                  - "arn:aws:s3:::sls-cross-account-shared-services-domain-deploy"
# #                  - "arn:aws:s3:::sls-cross-account-shared-services-domain-deploy/*"
# #              - Effect: "Allow"
# #                Action:
# #                  - sts:AssumeRole
# #                Resource:
# #                  - !Sub ${BaseAssumedServiceRole.Arn}
#
# data "aws_iam_policy_document" "tf_domain_resources_s3_resource_policy" {
#   statement {
#     actions   = [
#       "s3:PutObject",
#       "s3:GetObject",
#       "s3:GetBucketPolicy",
#       "s3:ListBucket",
#       "s3:ListAllMyBuckets",
#       "s3:GetBucketLocation"
#     ]
#     resources = [
#       "arn:aws:s3:::${var.deployment_bucket_name}",
#       "arn:aws:s3:::${var.deployment_bucket_name}/*"
#     ]
#     effect = "Allow"
#   }
# }
#
# data "aws_iam_policy_document" "tf_domain_resources_pipeline_execution_policy" {
#   statement {
#     actions   = [
#       "codepipeline:StartPipelineExecution"
#     ]
#     resources = [
#       "arn:aws:codepipeline:${var.aws_region}:${var.aws_account}:${var.aws_codepipeline_project_name}"
#     ]
#     effect = "Allow"
#   }
# }
#
# #   Policies:
# #        - PolicyName: !Sub ${ProjectName}-pipeline-execution
# #          PolicyDocument:
# #            Version: 2012-10-17
# #            Statement:
# #              - Effect: Allow
# #                Action: codepipeline:StartPipelineExecution
# #                Resource:
# #                  - !Join [ '', [ 'arn:aws:codepipeline:', !Ref 'AWS::Region', ':', !Ref 'AWS::AccountId', ':', !Ref CodeReplicationPipeline ] ]
