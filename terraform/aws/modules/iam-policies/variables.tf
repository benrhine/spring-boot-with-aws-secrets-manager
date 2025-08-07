########################################################################################################################
# Variable must be defined in order for the module to receive the arn in order to limit which roles can assume the base
# role.
########################################################################################################################
variable "policy_name" {
  description = "(Required) Policy name"
  type        = string
}

variable "policy_description" {
  description = "(Optional) Description of policy actions"
  type        = string
}

variable "policy" {
  description = "(Required) Policy declaration"
  type        = string
}

variable "policy_role" {
  description = "(Required) Role to attach policy to"
  type        = string
}

variable "policy_tags_project" {
  description = "What project is this part of?"
  type        = string
  nullable    = true
  #   default = "" # By not setting a default makes it a required field UNLESS nullable is true
}

variable "policy_tags_environment" {
  description = "What environment is this deployed to?"
  type        = string
  nullable    = true
  #   default     = "INSERT-ENVIRONMENT-NAME"
}

variable "policy_tags_origination" {
  description = "What repository is this deployed from?"
  type        = string
  nullable    = true
  #   default     = "INSERT-ENVIRONMENT-NAME"
}

# Allows for region to be passed in from calling module OR defaults to current execution environment retrieved in data.tf
# variable "aws_region" {
#   description = "(Required) AWS region"
#   type        = string
# }
#
# # Allows for region to be passed in from calling module OR defaults to current execution environment retrieved in data.tf
# variable "aws_account" {
#   description = "(Required) AWS Account"
#   type        = string
# }
#
# variable "policy_resource_arn" { # This value is used in the module data.tf
#   description = "(Required) The specific ARN to apply the policy to"
#   type        = string
# }
#
# variable "deployment_bucket_name" { # This value is used in the module data.tf
#   description = "(Required) Name of the S3 bucket which resources are deployed to"
#   type        = string
# }
#
# variable "aws_codepipeline_project_name" {
#   description = "(Required) Name of the given pipeline"
#   type        = string
# }

# variable "iam_policy_document_actions" {
#   description = "What policy actions are allowed"
#   type        = list(string)
# }
#
# variable "iam_policy_document_resources" {
#   description = "(Optional) Specific resources that the policy applies to"
#   type        = list(string)
#   default     = ["*"]
# }
#
#
# locals {
#   concatenated_string = "arn:aws:iam::, ${data.aws_region.current}:role/*"
# }
#
# variable "iam_policy_document_effect" {
#   description = "What is the policies effect?"
#   type        = string
#   default     = local.concatenated_string
# }
#
#
#
# output "concatenated_output" {
#   value = local.concatenated_string
# }

# variable "iam_policy_statements" {
#   type = list(object({
#     sid      = string
#     action   = list(string)
#     resource = string
#   }))
#   default = [
#     {
#       sid   = "tf_resource_iam_policy_all"
#       action   = [
#         "iam:AttachRolePolicy",
#         "iam:CreateRole",
#         "iam:GetRole",
#         "iam:PassRole",
#         "iam:DeleteRole",
#         "iam:DeleteRolePolicy",
#         "iam:DetachRolePolicy",
#         "iam:PutRolePolicy"
#       ]
#       resource = "*"
#     },
#     {
#       sid   = "tf_resource_iam_policy"
#       action   = [
#         "iam:AttachRolePolicy",
#         "iam:CreateRole",
#         "iam:GetRole",
#         "iam:PassRole",
#         "iam:DeleteRole",
#         "iam:DeleteRolePolicy",
#         "iam:DetachRolePolicy",
#         "iam:PutRolePolicy"
#       ]
#       resource = join("", ["arn:aws:iam::", data.aws_region.current, ":role/*"])
# #       resource = "arn:aws:iam::${data.aws_iam_policy_document}:role/*"
#     },
#     # Add more policy statements as needed
#   ]
# }
#
# locals {
#   iam_policy_document = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       for statement in var.iam_policy_statements : {
#         Action   = statement.action,
#         Effect   = "Allow",
#         Resource = statement.resource,
#       }
#     ]
#   })
# }

#
# variable "iam_policy_objects_to_create" {
#   type = list(object({
#     name        = string
#     description = string
#     policy      = string
#   }))
#
#   #   validation {
#   #     condition = alltrue([for x in var.iam_policy_objects_to_create : can(regex("^(tf.brr.)", x.name))])
#   #     error_message = "Property name must start with 'tf.brr'."
#   #   }
#
#   default = [
#     {
#       name        = "tf_resource_iam_policy_all"
#       description = "Custom IAM policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "iam:PutRolePolicy",
#               "iam:PassRole",
#               "iam:GetRole",
#               "iam:DetachRolePolicy",
#               "iam:DeleteRolePolicy",
#               "iam:DeleteRole",
#               "iam:CreateRole",
#               "iam:AttachRolePolicy"
#             ],
#             "Effect": "Allow",
#             "Resource": "*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_resource_iam_policy"
#       description = "Custom IAM policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "iam:PutRolePolicy",
#               "iam:PassRole",
#               "iam:GetRole",
#               "iam:DetachRolePolicy",
#               "iam:DeleteRolePolicy",
#               "iam:DeleteRole",
#               "iam:CreateRole",
#               "iam:AttachRolePolicy"
#             ],
#             "Effect": "Allow",
#             "Resource": "arn:aws:iam::XXXXXXXXXXX:role/*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_codebuild_resource_policy"
#       description = "Custom assume policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "codebuild:UpdateReport",
#               "codebuild:StopBuild",
#               "codebuild:StartBuild",
#               "codebuild:RetryBuild",
#               "codebuild:CreateReportGroup",
#               "codebuild:CreateReport",
#               "codebuild:BatchPutTestCases",
#               "codebuild:BatchPutCodeCoverages"
#             ],
#             "Effect": "Allow",
#             "Resource": "*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_codepipeline_resource_policy"
#       description = "Custom CodePipeline policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "codepipeline:UpdatePipeline",
#               "codepipeline:GetPipelineState",
#               "codepipeline:GetPipeline",
#               "codepipeline:DeletePipeline",
#               "codepipeline:CreatePipeline"
#             ],
#             "Effect": "Allow",
#             "Resource": "*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_ssm_policy"
#       description = "Custom SSM policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "ssm:PutParameter",
#               "ssm:DeleteParameter"
#             ],
#             "Effect": "Allow",
#             "Resource": "arn:aws:ssm:us-east-2:XXXXXXXXXXX:parameter/brr.*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_assume_role_policy"
#       description = "Custom assume policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": "sts:AssumeRole",
#             "Effect": "Allow",
#             "Resource": "arn:aws:iam::XXXXXXXXXXX:role/tf-base-us-east-2-assumed-service-role"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_codebuild_resource_simple_policy"
#       description = "Custom CodeBuild policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "codebuild:UpdateProject",
#               "codebuild:DeleteProject",
#               "codebuild:CreateProject"
#             ],
#             "Effect": "Allow",
#             "Resource": "*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_log_policy"
#       description = "Custom IAM policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "logs:TagResource",
#               "logs:PutQueryDefinition",
#               "logs:PutLogEvents",
#               "logs:CreateLogStream",
#               "logs:CreateLogGroup"
#             ],
#             "Effect": "Allow",
#             "Resource": "arn:aws:logs:*:*:*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_log_group_build_policy"
#       description = "Custom CodeBuild policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "logs:TagResource",
#               "logs:PutQueryDefinition",
#               "logs:PutLogEvents",
#               "logs:CreateLogStream",
#               "logs:CreateLogGroup"
#             ],
#             "Effect": "Allow",
#             "Resource": [
#               "arn:aws:logs:us-east-2:XXXXXXXXXXX:log-group:/aws/codebuild/tf-*",
#               "arn:aws:logs:us-east-2:XXXXXXXXXXX:log-group:/aws/codebuild/step-*",
#               "arn:aws:logs:us-east-2:XXXXXXXXXXX:log-group:/aws/codebuild/sls-*"
#             ]
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_s3_resource_policy"
#       description = "Custom CodePipeline policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "s3:PutObject",
#               "s3:PutAccelerateConfiguration",
#               "s3:GetObjectVersion",
#               "s3:GetObject",
#               "s3:GetBucketLocation",
#               "s3:GetBucketAcl"
#             ],
#             "Effect": "Allow",
#             "Resource": "*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_codecommit_resource_repo_policy"
#       description = "Custom CodeCommit policy for base role"
#       policy      = jsonencode(
#         {
#           "Statement": [
#             {
#               "Action": [
#                 "codecommit:GitPush",
#                 "codecommit:GitPull"
#               ],
#               "Effect": "Allow",
#               "Resource": "*"
#             }
#           ],
#           "Version": "2012-10-17"
#         }
#       )
#     },
#     {
#       name        = "tf_domain_resources_codepipeline_policy"
#       description = "Custom IAM policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "codepipeline:StopPipelineExecution",
#               "codepipeline:ListPipelineExecutions",
#               "codepipeline:GetPipelineExecution"
#             ],
#             "Effect": "Allow",
#             "Resource": "*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_resource_iam_pass_through_policy"
#       description = "tf_resource_iam_pass_through_policy"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": "iam:PassRole",
#             "Effect": "Allow",
#             "Resource": "*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_ssm_get_policy"
#       description = "tf_ssm_get_policy"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "ssm:GetParameters",
#               "ssm:GetParameter"
#             ],
#             "Effect": "Allow",
#             "Resource": "*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_domain_resources_everything_policy"
#       description = "Custom SSM policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "sns:Publish",
#               "lambda:ListFunctions",
#               "lambda:InvokeFunction",
#               "kms:Decrypt",
#               "iam:PassRole",
#               "ecs:*",
#               "ecr:DescribeImages",
#               "ec2:DescribeSecurityGroups",
#               "codestar-connections:UseConnection",
#               "codepipeline:StopPipelineExecution",
#               "codepipeline:ListPipelineExecutions",
#               "codepipeline:GetPipelineExecution",
#               "codepipeline:GetPipeline",
#               "codedeploy:*",
#               "codecommit:UploadArchive",
#               "codecommit:List*",
#               "codecommit:GitPush",
#               "codecommit:GitPull",
#               "codecommit:Get*",
#               "codecommit:CancelUploadArchive",
#               "codebuild:StartBuildBatch",
#               "codebuild:StartBuild",
#               "codebuild:BatchGetBuilds",
#               "codebuild:BatchGetBuildBatches",
#               "cloudwatch:*",
#               "cloudformation:*"
#             ],
#             "Effect": "Allow",
#             "Resource": "*"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_domain_resources_s3_resource_policy"
#       description = "Custom assume policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": [
#               "s3:PutObject",
#               "s3:ListBucket",
#               "s3:ListAllMyBuckets",
#               "s3:GetObject",
#               "s3:GetBucketPolicy",
#               "s3:GetBucketLocation"
#             ],
#             "Effect": "Allow",
#             "Resource": [
#               "arn:aws:s3:::tf-us-east-2-cross-account-shared-services/*",
#               "arn:aws:s3:::tf-us-east-2-cross-account-shared-services"
#             ]
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     },
#     {
#       name        = "tf_domain_resources_pipeline_execution_policy"
#       description = "Custom assume policy for base role"
#       policy      = jsonencode({
#         "Statement": [
#           {
#             "Action": "codepipeline:StartPipelineExecution",
#             "Effect": "Allow",
#             "Resource": "arn:aws:codepipeline:us-east-2:XXXXXXXXXXX:domain-resources-replication-pipeline"
#           }
#         ],
#         "Version": "2012-10-17"
#       })
#     }
#   ]
# }

# variable "iam_policy_objects_to_create" {
#   type = list(object({
#     actions = list(string)
#     resources = list(string)
#     effect = string
#   }))

  #   validation {
  #     condition = alltrue([for x in var.iam_policy_objects_to_create : can(regex("^(tf.brr.)", x.name))])
  #     error_message = "Property name must start with 'tf.brr'."
  #   }
# }

# variable "iam_policy_objects_to_create" {
#   type = list(object({
#     actions   = list(string)
#     resources = list(string)
#     effect    = string
#   }))
#
# #   validation {
# #     condition = alltrue([for x in var.iam_policy_objects_to_create : can(regex("^(tf.brr.)", x.name))])
# #     error_message = "Property name must start with 'tf.brr'."
# #   }
#
#   default = [
#     {
#       actions   = [
#         "iam:AttachRolePolicy",
#         "iam:CreateRole",
#         "iam:GetRole",
#         "iam:PassRole",
#         "iam:DeleteRole",
#         "iam:DeleteRolePolicy",
#         "iam:DetachRolePolicy",
#         "iam:PutRolePolicy"
#       ]
#       resources = ["*"]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "iam:AttachRolePolicy",
#         "iam:CreateRole",
#         "iam:GetRole",
#         "iam:PassRole",
#         "iam:DeleteRole",
#         "iam:DeleteRolePolicy",
#         "iam:DetachRolePolicy",
#         "iam:PutRolePolicy"
#       ]
#       resources = [
#         "arn:aws:iam::${var.aws_account}:role/*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "codebuild:CreateProject",
#         "codebuild:UpdateProject",
#         "codebuild:DeleteProject"
#       ]
#       resources = [
#         "*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "codepipeline:GetPipeline",
#         "codepipeline:CreatePipeline",
#         "codepipeline:UpdatePipeline",
#         "codepipeline:DeletePipeline",
#         "codepipeline:GetPipelineState"
#       ]
#       resources = [
#         "*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "ssm:PutParameter",
#         "ssm:DeleteParameter"
#       ]
#       resources = [
#         "arn:aws:ssm:${var.aws_region}:${var.aws_account}:parameter/brr.*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "sts:AssumeRole"
#       ]
#       resources = [
#         var.policy_resource_arn # look at this
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "logs:CreateLogGroup",
#         "logs:CreateLogStream",
#         "logs:PutLogEvents",
#         "logs:PutQueryDefinition",
#         "logs:TagResource"
#       ]
#       resources = [
#         "arn:aws:logs:*:*:*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "logs:CreateLogGroup",
#         "logs:CreateLogStream",
#         "logs:PutLogEvents",
#         "logs:PutQueryDefinition",
#         "logs:TagResource"
#       ]
#       resources = [
#         "arn:aws:logs:${var.aws_region}:${var.aws_account}:log-group:/aws/codebuild/tf-*",
#         "arn:aws:logs:${var.aws_region}:${var.aws_account}:log-group:/aws/codebuild/sls-*",
#         "arn:aws:logs:${var.aws_region}:${var.aws_account}:log-group:/aws/codebuild/step-*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "s3:PutObject",
#         "s3:GetObject",
#         "s3:GetObjectVersion",
#         "s3:GetBucketAcl",
#         "s3:GetBucketLocation",
#         "s3:PutAccelerateConfiguration"
#       ]
#       resources = [
#         "*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "codecommit:GitPull",
#         "codecommit:GitPush"
#       ]
#       resources = [
#         "*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "codebuild:CreateReportGroup",
#         "codebuild:CreateReport",
#         "codebuild:UpdateReport",
#         "codebuild:BatchPutTestCases",
#         "codebuild:BatchPutCodeCoverages",
#         "codebuild:StartBuild",
#         "codebuild:StopBuild",
#         "codebuild:RetryBuild"
#       ]
#       resources = [
#         "*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "codepipeline:GetPipelineExecution",
#         "codepipeline:StopPipelineExecution",
#         "codepipeline:ListPipelineExecutions"
#       ]
#       resources = [
#         "*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "iam:PassRole"
#       ]
#       resources = [
#         "*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "ssm:GetParameter",
#         "ssm:GetParameters"
#       ]
#       resources = [
#         "*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "codepipeline:GetPipeline",
#         "codepipeline:GetPipelineExecution",
#         "codepipeline:StopPipelineExecution",
#         "codepipeline:ListPipelineExecutions",
#         "codecommit:List*",
#         "codecommit:Get*",
#         "codecommit:GitPull",
#         "codecommit:GitPush",
#         "codecommit:UploadArchive",
#         "codecommit:CancelUploadArchive",
#         "codebuild:BatchGetBuilds",
#         "codebuild:BatchGetBuildBatches",
#         "codebuild:StartBuild",
#         "codebuild:StartBuildBatch",
#         "iam:PassRole",
#         "sns:Publish",
#         "ec2:DescribeSecurityGroups",
#         "cloudformation:*",
#         "codedeploy:*",
#         "cloudwatch:*",
#         "ecs:*",
#         "lambda:InvokeFunction",
#         "lambda:ListFunctions",
#         "codestar-connections:UseConnection",
#         "ecr:DescribeImages",
#         "kms:Decrypt"
#       ]
#       resources = [
#         "*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "s3:PutObject",
#         "s3:GetObject",
#         "s3:GetBucketPolicy",
#         "s3:ListBucket",
#         "s3:ListAllMyBuckets",
#         "s3:GetBucketLocation"
#       ]
#       resources = [
#         "arn:aws:s3:::${var.deployment_bucket_name}",
#         "arn:aws:s3:::${var.deployment_bucket_name}/*"
#       ]
#       effect    = "Allow"
#     },
#     {
#       actions   = [
#         "codepipeline:StartPipelineExecution"
#       ]
#       resources = [
#         "arn:aws:codepipeline:${var.aws_region}:${var.aws_account}:${var.aws_codepipeline_project_name}"
#       ]
#       effect    = "Allow"
#     },
#   ]
# }