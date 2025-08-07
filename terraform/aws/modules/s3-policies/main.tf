
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration

# HOW DO I SET THE DELETION POLICY - in research there is no equivalent to this in TF
# persistent resources need to be managed in a different project so TF can be ran differently

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.bucket_id                                    # Passed in from s3 module
  policy = data.aws_iam_policy_document.bucket_policy.json  # Created in THIS module
}

# ======================================================================================================================
# The following is the equivalent declaration in both Serverless Framework and CloudFormation for the above resource
# and the associated linked block in s3-policies/data.tf
# ======================================================================================================================
# DeploymentBucketPolicy:                                         # Resource name
#   Type: AWS::S3::BucketPolicy                                   # Resource type
#   DeletionPolicy: Retain                                        # DO NOT DELETE IF CLOUDFORMATION STACK IS REMOVED
#   DependsOn: DeployBucket                                       # Policy creation is dependent on bucket being previously created
#   Properties:
#     Bucket: !Sub ${AccountName}-${AWS::Region}-${S3DeploymentBucket}  # Set bucket name from configurable parameter
#     PolicyDocument:
#       Statement:
#       - Action:
#       - s3:GetLifecycleConfiguration
#       - s3:ListBucket
#       - s3:Get*
#       - s3:PutObject
#       - s3:DeleteObject
#       Resource:                                             # Limit permissions to THIS bucket
#       - !Sub arn:aws:s3:::${AccountName}-${AWS::Region}-${S3DeploymentBucket}
#       - !Sub arn:aws:s3:::${AccountName}-${AWS::Region}-${S3DeploymentBucket}/*
#                   Effect: Allow
#                   Principal:
#                     AWS:
#                       - arn:aws:iam::NP-ACCOUNT-NUM:role/sls-external-service-role
#                       - arn:aws:iam::P-ACCOUNT-NUM:role/sls-external-service-role