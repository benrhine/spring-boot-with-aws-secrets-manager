########################################################################################################################
# To view module outputs at runtime, outputs must be re-declared in root module outputs.tf.
########################################################################################################################
output "aws_s3_bucket_policy" {
  description = "Base service role id"
  value       = aws_s3_bucket_policy.bucket_policy
}