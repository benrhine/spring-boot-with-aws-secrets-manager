

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = local.bucket_policy_identifiers
    }
    actions = var.bucket_policy_allowed_actions

    resources = [
      var.bucket_arn,
      "${var.bucket_arn}/*",
    ]
  }
}

# ======================================================================================================================
# The following section in * is equivalent to the above
# ======================================================================================================================
# DeploymentBucketPolicy:                                         # Resource name
#   Type: AWS::S3::BucketPolicy                                   # Resource type
#   DeletionPolicy: Retain                                        # DO NOT DELETE IF CLOUDFORMATION STACK IS REMOVED
#   DependsOn: DeployBucket                                       # Policy creation is dependent on bucket being previously created
#   Properties:
#     Bucket: !Sub ${AccountName}-${AWS::Region}-${S3DeploymentBucket}  # Set bucket name from configurable parameter
# **********************************************************************************************************************
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
# **********************************************************************************************************************