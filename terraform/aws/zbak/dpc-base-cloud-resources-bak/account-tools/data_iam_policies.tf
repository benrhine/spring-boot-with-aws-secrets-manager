########################################################################################################################
# Declared IAM policy data
# Each data block is declared as follows `data "RESOURCE-TYPE" "RESOURCE-NAME" {}`
# Resource-type is defined by terraform, resource-name is user defined (can essentially be anything)
########################################################################################################################
data "aws_iam_policy_document" "tf_account_resources_iam_all" {
  statement {
    actions = [
      "iam:AttachRolePolicy",
      "iam:CreateRole",
      "iam:GetRole",
      "iam:PassRole",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "tf_account_resources_iam" {
  statement {
    actions = [
      "iam:AttachRolePolicy",
      "iam:CreateRole",
      "iam:GetRole",
      "iam:PassRole",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy"
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "tf_account_resources_codebuild_resource_simple" { // this one
  statement {
    actions = [
      "codebuild:CreateProject",
      "codebuild:UpdateProject",
      "codebuild:DeleteProject"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "tf_account_resources_codepipeline" {
  statement {
    actions = [
      "codepipeline:GetPipeline",
      "codepipeline:CreatePipeline",
      "codepipeline:UpdatePipeline",
      "codepipeline:DeletePipeline",
      "codepipeline:GetPipelineState"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

# data "aws_iam_role" "create_base_service_role_data" {
#   arn = var.create_base_assumed_service_role
# }

data "aws_iam_policy_document" "tf_account_resources_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    #     resources = [var.policy_resource_arn]
    resources = [module.base_assumed_service_role.created_role_arn]
    effect    = "Allow"
  }
}

#          PolicyDocument:
#            Version: '2012-10-17'
#            Statement:
#              - Effect: Allow
#                Action:
#                  - sts:AssumeRole
#                Resource:
#                  - !Sub ${BaseAssumedServiceRole.Arn}

# sls-domain-codebuild-build-deploy-resources-service-role
data "aws_iam_policy_document" "tf_account_resources_log" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutQueryDefinition",
      "logs:TagResource",
      "logs:DescribeQueryDefinitions",
      "logs:DeleteQueryDefinition"
    ]
    resources = ["arn:aws:logs:*:*:*"]
    effect    = "Allow" # note that these rights are given in the default policy and are required if you want logs out of your lambda(s)
  }
}

# Policies:
#   - PolicyName: cf-log-policy
#     PolicyDocument:
#       Version: '2012-10-17'
#       Statement:
#         - Effect: Allow # note that these rights are given in the default policy and are required if you want logs out of your lambda(s)
#           Action:
#             - logs:CreateLogGroup
#             - logs:CreateLogStream
#             - logs:PutLogEvents
#             - logs:PutQueryDefinition
#             - logs:TagResource
#           Resource:
#             - 'arn:aws:logs:*:*:*'

# sls-domain-codebuild-build-deploy-resources-service-role
data "aws_iam_policy_document" "tf_account_resources_log_group_build" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutQueryDefinition",
      "logs:TagResource"
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/tf-*",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/sls-*",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/step-*"
    ]
    effect = "Allow" # note that these rights are given in the default policy and are required if you want logs out of your lambda(s)
  }
}

#   - PolicyName: cf-log-group-build-policy
#          PolicyDocument:
#            Version: '2012-10-17'
#            Statement:
#              - Effect: Allow
#                Action:
#                  - logs:CreateLogGroup
#                  - logs:CreateLogStream
#                  - logs:PutLogEvents
#                  - logs:PutQueryDefinition
#                  - logs:TagResource
#                Resource:
#                  - Fn::Join:
#                      - ':'
#                      - - 'arn:aws:logs'
#                        - Ref: 'AWS::Region'
#                        - Ref: 'AWS::AccountId'
#                        - log-group:/aws/codebuild/cf-*
#                  - Fn::Join:
#                      - ':'
#                      - - 'arn:aws:logs'
#                        - Ref: 'AWS::Region'
#                        - Ref: 'AWS::AccountId'
#                        - log-group:/aws/codebuild/sls-*
#                  - Fn::Join:
#                      - ':'
#                      - - 'arn:aws:logs'
#                        - Ref: 'AWS::Region'
#                        - Ref: 'AWS::AccountId'
#                        - log-group:/aws/codebuild/step-*

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

#        - PolicyName: cf-s3-resource-policy
#          PolicyDocument:
#            Version: '2012-10-17'
#            Statement:
#              - Effect: Allow
#                Action:
#                  - s3:PutObject
#                  - s3:GetObject
#                  - s3:GetObjectVersion
#                  - s3:GetBucketAcl
#                  - s3:GetBucketLocation
#                  - s3:PutAccelerateConfiguration
#                Resource:
#                  - '*'

data "aws_iam_policy_document" "tf_account_resources_codecommit_repo" {
  statement {
    actions = [
      "codecommit:GitPull",
      "codecommit:GitPush"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

#        - PolicyName: cf-codecommit-resource-repo-policy
#          PolicyDocument:
#            Version: '2012-10-17'
#            Statement:
#              - Effect: Allow
#                Action:
#                  - codecommit:GitPull
#                  - codecommit:GitPush
#                Resource:
#                  - '*'

data "aws_iam_policy_document" "tf_account_resources_codebuild" {
  statement {
    actions = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages",
      "codebuild:StartBuild",
      "codebuild:StopBuild",
      "codebuild:RetryBuild"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}
#        - PolicyName: cf-codebuild-resource-policy
#          PolicyDocument:
#            Version: '2012-10-17'
#            Statement:
#              - Effect: Allow
#                Action:
#                  - codebuild:CreateReportGroup
#                  - codebuild:CreateReport
#                  - codebuild:UpdateReport
#                  - codebuild:BatchPutTestCases
#                  - codebuild:BatchPutCodeCoverages
#                  - codebuild:StartBuild
#                  - codebuild:StopBuild
#                  - codebuild:RetryBuild
#                Resource:
#                  - '*'

data "aws_iam_policy_document" "tf_account_resources_codepipeline_simple" {
  statement {
    actions = [
      "codepipeline:GetPipelineExecution",
      "codepipeline:StopPipelineExecution",
      "codepipeline:ListPipelineExecutions"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}
#        - PolicyName: !Sub ${ProjectName}-codepipeline-policy
#          PolicyDocument:
#            Version: '2012-10-17'
#            Statement:
#              - Effect: Allow
#                Action:
#                  - codepipeline:GetPipelineExecution
#                  - codepipeline:StopPipelineExecution
#                  - codepipeline:ListPipelineExecutions
#                Resource:
#                  - '*'

data "aws_iam_policy_document" "tf_account_resources_iam_pass_through" {
  statement {
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}
#        - PolicyName: cf-resource-iam-policy
#          PolicyDocument:
#            Version: '2012-10-17'
#            Statement:
#              - Effect: Allow
#                Action:
#                  - iam:PassRole
#                Resource:
#                  - '*'

data "aws_iam_policy_document" "tf_account_resources_ssm_get" {
  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "tf_account_resources_ssm" {
  statement {
    actions = [
      "ssm:PutParameter",
      "ssm:DeleteParameter"
    ]
    resources = ["arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.framework_prefix}.brr.*"]
    effect    = "Allow"
  }
}

# Not sure why but Terraform wanted additional permissions that are not required by CF or SLS in order to deploy parameters
data "aws_iam_policy_document" "tf_account_resources_ssm_all" {
  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:PutParameter",
      "ssm:DeleteParameter",
      "ssm:AddTagsToResource",
      "ssm:DescribeParameters",
      "ssm:ListTagsForResource"
    ]
    resources = ["*"]
    # resources = ["arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.framework_prefix}.brr.*"]
    effect = "Allow"
  }
}
#        - PolicyName: cf-ssm-policy
#          PolicyDocument:
#            Version: '2012-10-17'
#            Statement:
#              - Effect: Allow # note that these rights are given in the default policy and are required if you want logs out of your lambda(s)
#                Action:
#                  - ssm:GetParameter
#                  - ssm:GetParameters
#                Resource:
#                  - '*'

data "aws_iam_policy_document" "tf_account_resources_everything" {
  statement {
    actions = [
      "codepipeline:GetPipeline",
      "codepipeline:GetPipelineExecution",
      "codepipeline:StopPipelineExecution",
      "codepipeline:ListPipelineExecutions",
      "codecommit:List*",
      "codecommit:Get*",
      "codecommit:GitPull",
      "codecommit:GitPush",
      "codecommit:UploadArchive",
      "codecommit:CancelUploadArchive",
      "codebuild:BatchGetBuilds",
      "codebuild:BatchGetBuildBatches",
      "codebuild:StartBuild",
      "codebuild:StartBuildBatch",
      "iam:PassRole",
      "sns:Publish",
      "ec2:DescribeSecurityGroups",
      "cloudformation:*",
      "codedeploy:*",
      "cloudwatch:*",
      "ecs:*",
      "lambda:InvokeFunction",
      "lambda:ListFunctions",
      "codestar-connections:UseConnection",
      "ecr:DescribeImages",
      "kms:Decrypt"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}


#   Policies:
#        - PolicyName: !Sub ${ProjectName}-everything-policy
#          PolicyDocument:
#            Version: 2012-10-17
#            Statement:
#              - Effect: Allow
#                Action:
#                  - codepipeline:GetPipeline
#                  - codepipeline:GetPipelineExecution
#                  - codepipeline:StopPipelineExecution
#                  - codepipeline:ListPipelineExecutions
#                  - codecommit:List*
#                  - codecommit:Get*
#                  - codecommit:GitPull
#                  - codecommit:GitPush
#                  - codecommit:UploadArchive
#                  - codecommit:CancelUploadArchive
#                  - codebuild:BatchGetBuilds
#                  - codebuild:BatchGetBuildBatches
#                  - codebuild:StartBuild
#                  - codebuild:StartBuildBatch
#                  - iam:PassRole
#                  - sns:Publish
#                  - ec2:DescribeSecurityGroups
#                  - cloudformation:*
#                  - codedeploy:*
#                  - cloudwatch:*
#                  - ecs:*
#                  - lambda:InvokeFunction
#                  - lambda:ListFunctions
#                  - codestar-connections:UseConnection
#                  - ecr:DescribeImages
#                Resource:
#                  - "*"
#              - Effect: Allow
#                Action:
#                  - kms:Decrypt
#                Resource: "*"
#              - Effect: Allow
#                Action:
#                  - s3:PutObject
#                  - s3:GetBucketPolicy
#                  - s3:GetObject
#                  - s3:ListBucket
#                  - s3:ListAllMyBuckets
#                  - s3:GetBucketLocation
#                Resource:
#                  - !Sub arn:aws:s3:::${AccountName}-${AWS::Region}-${S3DeploymentBucket}
#                  - !Sub arn:aws:s3:::${AccountName}-${AWS::Region}-${S3DeploymentBucket}/*
#                  - "arn:aws:s3:::sls-cross-account-shared-services-domain-deploy"
#                  - "arn:aws:s3:::sls-cross-account-shared-services-domain-deploy/*"
#              - Effect: "Allow"
#                Action:
#                  - sts:AssumeRole
#                Resource:
#                  - !Sub ${BaseAssumedServiceRole.Arn}

data "aws_iam_policy_document" "tf_account_resources_s3_restricted" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetBucketPolicy",
      "s3:ListBucket",
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation"
    ]
    resources = [
      "*"
      #       "arn:aws:s3:::${module.s3.aws_s3_bucket.bucket}",
      #       "arn:aws:s3:::${module.s3.aws_s3_bucket.bucket}/*"
    ]
    effect = "Allow"
  }
}

# data "aws_iam_policy_document" "tf_domain_resources_pipeline_execution_policy" {
#   statement {
#     actions   = [
#       "codepipeline:StartPipelineExecution"
#     ]
#     resources = [
# #       "arn:aws:codepipeline:${data.aws_region.current.name}:${data.aws_caller_identity.current}:blah"
#       "arn:aws:codepipeline:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${module.codepipeline.aws_codepipeline_project_name}"
#     ]
#     effect = "Allow"
#   }
# }

#   Policies:
#        - PolicyName: !Sub ${ProjectName}-pipeline-execution
#          PolicyDocument:
#            Version: 2012-10-17
#            Statement:
#              - Effect: Allow
#                Action: codepipeline:StartPipelineExecution
#                Resource:
#                  - !Join [ '', [ 'arn:aws:codepipeline:', !Ref 'AWS::Region', ':', !Ref 'AWS::AccountId', ':', !Ref CodeReplicationPipeline ] ]

data "aws_iam_policy_document" "tf_account_resources_code_connections" {
  statement {
    actions = [
      "codeconnections:GetConnectionToken",
      "codeconnections:GetConnection"
    ]
    resources = ["arn:aws:codeconnections:${data.aws_region.current.name}:${var.account_tools}:connection/568df767-2b69-4f6e-8005-95968e568aaa"]
    effect    = "Allow"
  }
}

# - PolicyName: !Sub ${FrameworkPrefix}-code-connections-policy
# PolicyDocument:
# Version: '2012-10-17'
# Statement:
# - Effect: Allow
# Action:
# - codeconnections:GetConnectionToken
# - codeconnections:GetConnection
# Resource:
# - arn:aws:codeconnections:us-east-2:792981815698:connection/568df767-2b69-4f6e-8005-95968e568aaa

data "aws_iam_policy_document" "tf_account_resources_cloudformation" {
  statement {
    actions = [
      "cloudformation:*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

# - PolicyName: ${self:custom.frameworkPrefix}-cloudformation-policy
# PolicyDocument:
# Version: '2012-10-17'
# Statement:
# - Effect: Allow # note that these rights are given in the default policy and are required if you want logs out of your lambda(s)
# Action:
# - cloudformation:*
# Resource:
# - '*'
