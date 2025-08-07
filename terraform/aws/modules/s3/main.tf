

# Import required modules


resource "aws_s3_bucket" "create_bucket" {
  bucket = var.create_bucket_name

  # HOW DO I SET THE DELETION POLICY - in research there is no equivalent to this in TF
  # persistent resources need to be managed in a different project so TF can be ran differently

  tags = {
    environment = var.s3_tags_environment
    origination = var.s3_tags_origination
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "create_bucket_encryption_configuration" {
  bucket = aws_s3_bucket.create_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.create_bucket_sse_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "create_bucket_public_access" {
  bucket = aws_s3_bucket.create_bucket.id

  block_public_acls       = var.create_bucket_block_public_acls
  block_public_policy     = var.create_bucket_block_public_policy
  ignore_public_acls      = var.create_bucket_ignore_public_acls
  restrict_public_buckets = var.create_bucket_ignore_public_acls
}

# ======================================================================================================================
# The following is the equivalent declaration in both Serverless Framework and CloudFormation for the above resource
# and the associated linked block in s3-policies/data.tf
# ======================================================================================================================
# DeployBucket:                                                   # Create S3 bucket to contain ALL sls deployments
#   Type: AWS::S3::Bucket                                         # Resource type
#   DeletionPolicy: Retain                                        # DO NOT DELETE IF CLOUDFORMATION STACK IS REMOVED
#   Properties:
#     BucketName: !Sub ${AccountName}-${AWS::Region}-${S3DeploymentBucket}  # Set bucket name from configurable parameter
#     BucketEncryption:                                           # Configure bucket encryption
#       ServerSideEncryptionConfiguration:
#         - ServerSideEncryptionByDefault:
#             SSEAlgorithm: AES256
#     PublicAccessBlockConfiguration:                             # Configure public access - make sure all public access is blocked
#       BlockPublicAcls: true
#       BlockPublicPolicy: true
#       IgnorePublicAcls: true
#       RestrictPublicBuckets: true