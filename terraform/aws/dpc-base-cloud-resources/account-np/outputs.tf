output "s3_tf_state_bucket_name" {
  description = "Base role to be assumed name"
  value       = module.s3_tf_state_bucket.aws_s3_bucket_name
}

output "s3_tf_state_bucket_arn" {
  description = "Base role to be assumed name"
  value       = module.s3_tf_state_bucket.aws_s3_bucket_arn
}

output "github_oidc_assume_role_name" {
  description = "Base role to be assumed name"
  value       = module.github_oidc_assume_role.created_role_name
}

output "github_oidc_assume_role_arn" {
  description = "Base role to be assumed name"
  value       = module.github_oidc_assume_role.created_role_arn
}

output "s3_tf_state_bucket_property_arn" {
  description = "Base role to be assumed name"
  value       = module.s3_tf_state_bucket_property_name.aws_ssm_property_arn
}