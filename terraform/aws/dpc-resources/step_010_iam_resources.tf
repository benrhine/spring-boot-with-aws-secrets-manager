########################################################################################################################
# IAM Roles Module Declaration: This module is used to define all Aws IAM roles.
#
# NOTE: THIS MODULE DOES NOT HAVE ANY DEPENDENCIES!!!
########################################################################################################################

# This should be the equivalent to
# - sls-domain-admin-role
# - cf-base-${AWS::Region}-assumed-service-role
module "base_assumed_service_role" {
  providers = {
    aws = aws.brr-tools
  }
  source                        = "../modules/iam-roles"                                   # Where to find the module
  ######################################################################################################################   # Value passed in via variables.tf
  iam_role_name                 = "${var.framework_prefix}_base_assumed_service_role"
  iam_role_description          = "This is the base role that will be assumed"
  iam_assume_role_policy        = data.aws_iam_policy_document.base_assumed_role_trust_relationship.json
  iam_tags_environment          = var.tag_environment_tools
  iam_tags_origination          = var.tag_origination_repo
  iam_tags_project              = var.project_name
}

# Which makes this the same as ...
# -
# - cf-base-${AWS::Region}-service-role
module "base_service_role" {
  providers = {
    aws = aws.brr-tools
  }
  source                        = "../modules/iam-roles"                                   # Where to find the module
  ######################################################################################################################   # Value passed in via variables.tf
  iam_role_name                 = "${var.framework_prefix}_base_service_role"
  iam_role_description          = "This is the base role that will be used to deploy resources"
  iam_assume_role_policy        = data.aws_iam_policy_document.base_role_trust_relationship.json
  iam_tags_environment          = var.tag_environment_tools
  iam_tags_origination          = var.tag_origination_repo
  iam_tags_project              = var.project_name

  depends_on = [
    module.base_assumed_service_role
  ]
}

# This role may be redundant and may operate the same as the base-service-role, I had the realization that the CloudFormation
# for this project is incomplete and basically was a re-working of existing work but that the CF template for this project has not been
# run... Meaning there were simplifications in that file that are not being used in the real world at this point and time.
# - cb-domain-${AWS::Region}-resource-deploy-service-role
# - sls-domain-codebuild-build-deploy-resources-service-role
module "codebuild_service_role" {
  providers = {
    aws = aws.brr-tools
  }
  source                        = "../modules/iam-roles"                                   # Where to find the module
  ######################################################################################################################   # Value passed in via variables.tf
  iam_role_name                 = "${var.framework_prefix}_cb_${var.project_name}_service_role"
  iam_role_description          = "This is the base role that will be assumed"
  iam_role_path                 = "/service-role/"
  iam_assume_role_policy        = data.aws_iam_policy_document.codebuild_role_trust_relationship.json
  iam_tags_environment          = var.tag_environment_tools
  iam_tags_origination          = var.tag_origination_repo
  iam_tags_project              = var.project_name

  depends_on = [
    module.base_assumed_service_role
  ]
}

# - ${ProjectName}-${AWS::Region}-codepipeline-role
module "codepipeline_service_role" {
  providers = {
    aws = aws.brr-tools
  }
  source                        = "../modules/iam-roles"                                   # Where to find the module
  ######################################################################################################################   # Value passed in via variables.tf
  iam_role_name                 = "${var.framework_prefix}_cp_${var.project_name}_service_role"
  iam_role_description          = "This is the base role that will be assumed"
  iam_role_path                 = "/service-role/"
  iam_assume_role_policy        = data.aws_iam_policy_document.codepipeline_role_trust_relationship.json
  iam_tags_environment          = var.tag_environment_tools
  iam_tags_origination          = var.tag_origination_repo
  iam_tags_project              = var.project_name

  depends_on = [
    module.base_assumed_service_role
  ]
}

module "codepipeline_event_rule_role" {
  providers = {
    aws = aws.brr-tools
  }
  source                        = "../modules/iam-roles"                                   # Where to find the module
  ######################################################################################################################   # Value passed in via variables.tf
  iam_role_name                 = "${var.framework_prefix}_cp_er_${var.project_name}_service_role"
  iam_role_description          = "This role allows for the CodePipeline to execute"
  iam_assume_role_policy        = data.aws_iam_policy_document.codepipeline_event_rule_role_trust_relationship.json
  iam_tags_environment          = var.tag_environment_tools
  iam_tags_origination          = var.tag_origination_repo
  iam_tags_project              = var.project_name
}


# SERVERLESS FRAMEWORK EXAMPLE OF THIS MODULE
#
#  BaseAssumedServiceRole:
#    Type: AWS::IAM::Role                                          # Resource type
#    Properties:                                                   # Resource properties
#      RoleName: !Sub cf-base-${AWS::Region}-assumed-service-role
#      AssumeRolePolicyDocument:                                   # Role Configuration
#        Version: '2012-10-17'
#        Statement:
#          - Effect: Allow
#            Principal:
#              AWS:
#                - arn:aws:iam::XXXXXXXXXXX:root
#            Action: sts:AssumeRole
#      ManagedPolicyArns:                                          # Managed policies to attach to new role
#        - arn:aws:iam::aws:policy/PowerUserAccess                 # If needed update to AdministratorAccess, but should not be needed
#        - arn:aws:iam::aws:policy/AdministratorAccess             # Admin is required to delete
#      Policies:
#       ...
#  BaseServiceRole:
#    Type: AWS::IAM::Role                                          # Resource type
#    DependsOn: BaseAssumedServiceRole                      # REQUIRES!!! Previous role has already been created
#    Properties:                                                   # Resource properties
#      RoleName: !Sub cf-base-${AWS::Region}-service-role
#      AssumeRolePolicyDocument:                                   # Role Configuration
#        Version: '2012-10-17'
#        Statement:
#          - Effect: Allow
#            Principal:
#              Service:
#                - codebuild.amazonaws.com
#                - cloudformation.amazonaws.com
#                - codepipeline.amazonaws.com
#            Action: sts:AssumeRole
#      Policies:
#       ...
#  CodeBuildServiceRole:                                    # Role that is applied to ALL CodeBuild jobs
#    Type: AWS::IAM::Role                                          # Resource type
#    DependsOn: BaseAssumedServiceRole                      # REQUIRES!!! Previous role has already been created
#    Properties:                                                   # Resource properties
#      Path: /service-role/                                        # If you want a custom resource path
#      RoleName: !Sub cb-domain-${AWS::Region}-resource-deploy-service-role
#      AssumeRolePolicyDocument:                                   # Role Configuration
#        Version: '2012-10-17'
#        Statement:
#          - Effect: Allow
#            Principal:
#              Service:
#                - codebuild.amazonaws.com
#            Action: sts:AssumeRole
#      Policies:
#       ...
#  CodePipelineServiceRole: # The following role is used in support of the pipeline
#    Type: AWS::IAM::Role
#    DependsOn: BaseAssumedServiceRole
#    Properties:
#      Path: /service-role/                                        # If you want a custom resource path
#      RoleName: !Sub ${ProjectName}-${AWS::Region}-codepipeline-role
#      AssumeRolePolicyDocument:
#        Version: 2012-10-17
#        Statement:
#          - Effect: Allow
#            Principal:
#              Service:
#                - codepipeline.amazonaws.com
#            Action:
#              - sts:AssumeRole
#      Policies:
#       ...
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
#       ...