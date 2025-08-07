
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter

resource "aws_ssm_parameter" "create_system_manager_property" {
  name          = var.property_name
  description   = var.property_description  # In order to use a variable it must be declared in variables.tf
  tier          = var.property_tier
  type          = var.property_type
  data_type     = var.property_data_type
  value         = var.property_value                                     # In order to use a variable it must be declared in variables.tf

  tags = {
    environment = var.property_tags_environment
    origination = var.property_tags_origination
  }
}

# ======================================================================================================================
# The following is the equivalent declaration in both Serverless Framework and CloudFormation
# ======================================================================================================================
# DeploymentBucketNameProperty:
#   Type: AWS::SSM::Parameter
#   Properties:
#   Name: brr.tools.build.s3.bucket.name
#   Description: !Sub Deployment bucket created by ${ProjectName}
#   DataType: text
#   Tier: Standard
#   Type: String
#   Value: !Sub ${AccountName}-${AWS::Region}-${S3DeploymentBucket}
#   Tags:
#     Environment: build


# ======================================================================================================================
# The following is the equivalent declaration in both Serverless Framework and CloudFormation
# ======================================================================================================================
# DeploymentLegacyBucketNameProperty:
#   Type: AWS::SSM::Parameter
#   Properties:
#   Name: brr.tools.build.s3.legacy.bucket.name
#   Description: Deployment bucket created by deprecated sls-domain-resources-deploy
#   DataType: text
#   Tier: Standard
#   Type: String
#   Value: sls-cross-account-shared-services-domain-deploy
#   Tags:
#     Environment: build