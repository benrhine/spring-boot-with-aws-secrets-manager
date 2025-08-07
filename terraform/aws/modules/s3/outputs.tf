########################################################################################################################
# To view module outputs at runtime, outputs must be re-declared in root module outputs.tf.
########################################################################################################################
output "aws_s3_bucket" {
  description = "Base service role ARN"
  value       = aws_s3_bucket.create_bucket
}

output "aws_s3_bucket_name" {
  description = "Base service role name"
  value       = aws_s3_bucket.create_bucket.bucket
}

output "aws_s3_bucket_arn" {
  description = "Base service role ARN"
  value       = aws_s3_bucket.create_bucket.arn
}