resource "aws_iam_role" "new_role" {
  name                = var.iam_role_name
  description         = var.iam_role_description
  path                = var.iam_role_path
  assume_role_policy  = var.iam_assume_role_policy

  tags = {
    environment = var.iam_tags_environment
    origination = var.iam_tags_origination
  }
}

########################################################################################################################
# Create the assumed role
########################################################################################################################
# Naming Convention for resources:
# resource-type | resource-name
#
# resource-type: is predefined by terraform and can be referenced in the documentation
# resource-name: can be anything the user desires
#
# Recommendation: Use the resource-name to group like components of a given resource. i.e. unless something needs to be
# unique so that it can be declared in outputs.tf use the same resource-name for all related items
########################################################################################################################
# resource "aws_iam_role" "base_assumed_service_role" {
#   name = "tf-base-${var.aws_region}-assumed-service-role"
#   description = "This is the base role that will be assumed"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#       {
#           "Effect": "Allow",
#           "Principal": {
#               "AWS": "arn:aws:iam::XXXXXXXXXXX:root"
#           },
#           "Action": "sts:AssumeRole"
#       }
#   ]
# }
# EOF
# }

# SERVERLESS FRAMEWORK EXAMPLE OF THIS ROLE
#

########################################################################################################################
# END create assumed role
########################################################################################################################

########################################################################################################################
# Create the base role
########################################################################################################################
# Naming Convention for resources:
# resource-type | resource-name
#
# resource-type: is predefined by terraform and can be referenced in the documentation
# resource-name: can be anything the user desires
#
# Recommendation: Use the resource-name to group like components of a given resource. i.e. unless something needs to be
# unique so that it can be declared in outputs.tf use the same resource-name for all related items
########################################################################################################################
# resource "aws_iam_role" "base_service_role" {
#   name = "tf-base-${var.aws_region}-service-role"
#   description = "This is the base role that will be used to deploy resources"
#   assume_role_policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Principal": {
#                 "Service": [
#                     "codepipeline.amazonaws.com",
#                     "codebuild.amazonaws.com",
#                     "cloudformation.amazonaws.com"
#                 ]
#             },
#             "Action": "sts:AssumeRole"
#         }
#     ]
# }
# EOF
#   depends_on = [
#     aws_iam_role.base_assumed_service_role
#   ]
# }

# SERVERLESS FRAMEWORK EXAMPLE OF THIS ROLE
#

########################################################################################################################
# END create base role
########################################################################################################################

########################################################################################################################
# Create the CodeBuild service role
########################################################################################################################
# Naming Convention for resources:
# resource-type | resource-name
#
# resource-type: is predefined by terraform and can be referenced in the documentation
# resource-name: can be anything the user desires
#
# Recommendation: Use the resource-name to group like components of a given resource. i.e. unless something needs to be
# unique so that it can be declared in outputs.tf use the same resource-name for all related items
########################################################################################################################
# resource "aws_iam_role" "codebuild_service_role" {
#   name = "tf-${var.project_name}-${var.aws_region}-resource-deploy-service-role"
#   description = "This is the base role that will be assumed"
#   path = "/service-role/"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#       {
#           "Effect": "Allow",
#           "Principal": {
#               "Service": [
#                   "codebuild.amazonaws.com"
#               ]
#           },
#           "Action": "sts:AssumeRole"
#       }
#   ]
# }
# EOF
#   depends_on = [
#     aws_iam_role.base_assumed_service_role
#   ]
# }

# SERVERLESS FRAMEWORK EXAMPLE OF THIS ROLE
#

########################################################################################################################
# END create CodeBuild service role
########################################################################################################################

########################################################################################################################
# Create the CodePipeline service role
########################################################################################################################
# Naming Convention for resources:
# resource-type | resource-name
#
# resource-type: is predefined by terraform and can be referenced in the documentation
# resource-name: can be anything the user desires
#
# Recommendation: Use the resource-name to group like components of a given resource. i.e. unless something needs to be
# unique so that it can be declared in outputs.tf use the same resource-name for all related items
########################################################################################################################
# resource "aws_iam_role" "codepipeline_service_role" {
#   name = "${var.project_name}-${var.aws_region}-codepipeline-role"
#   description = "This is the base role that will be assumed"
#   path = "/service-role/"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#       {
#           "Effect": "Allow",
#           "Principal": {
#               "Service": [
#                   "codepipeline.amazonaws.com"
#               ]
#           },
#           "Action": "sts:AssumeRole"
#       }
#   ]
# }
# EOF
#   depends_on = [
#     aws_iam_role.base_assumed_service_role
#   ]
# }

# SERVERLESS FRAMEWORK EXAMPLE OF THIS ROLE
#

########################################################################################################################
# END create CodePipeline service role
########################################################################################################################

# resource "aws_iam_role" "codepipeline_event_rule_role" {
#   name                = "tf-codepipeline-${var.aws_region}-event-rule-role"
#   description         = "This role allows for the CodePipeline to execute"
#   path                = "/"
#   assume_role_policy  = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Principal": {
#                 "Service": [
#                     "events.amazonaws.com"
#                 ]
#             },
#             "Action": "sts:AssumeRole"
#         }
#     ]
# }
# EOF
# }

# SERVERLESS FRAMEWORK EXAMPLE OF THIS ROLE
#
#  CodePipelineEventRuleRole: # This role is REQUIRED for the event rule to execute
#    Type: AWS::IAM::Role
#    Properties:
#      AssumeRolePolicyDocument:
#        Version: 2012-10-17
#        Statement:
#          - Effect: Allow
#            Principal:
#              Service:
#                - events.amazonaws.com
#            Action: sts:AssumeRole
#      Path: /
#      Policies:
#        - PolicyName: !Sub ${ProjectName}-pipeline-execution
#          PolicyDocument:
#            Version: 2012-10-17
#            Statement:
#              - Effect: Allow
#                Action: codepipeline:StartPipelineExecution
#                Resource:
#                  - !Join [ '', [ 'arn:aws:codepipeline:', !Ref 'AWS::Region', ':', !Ref 'AWS::AccountId', ':', !Ref CodeReplicationPipeline ] ]

########################################################################################################################
# END create CodePipeline service role
########################################################################################################################