########################################################################################################################
# To view module outputs at runtime, outputs must be re-declared in root module outputs.tf.
########################################################################################################################
output "created_role" {
  description = "Base role to be assumed name"
  value       = aws_iam_role.new_role
}

output "created_role_name" {
  description = "Base role to be assumed name"
  value       = aws_iam_role.new_role.name
}

output "created_role_arn" {
  description = "Base role to be assumed name"
  value       = aws_iam_role.new_role.arn
}
#
# output "create_base_assumed_service_role" {
#   description = "Base role to be assumed name"
#   value       = aws_iam_role.base_assumed_service_role
# }
#
# output "create_base_assumed_service_role_name" {
#   description = "Base role to be assumed name"
#   value       = aws_iam_role.base_assumed_service_role.name
# }
#
# output "create_base_assumed_service_role_arn" {
#   description = "Base role to be assumed ARN"
#   value       = aws_iam_role.base_assumed_service_role.arn
# }
#
# output "create_base_service_role" {
#   description = "Base service role"
#   value       = aws_iam_role.base_service_role
# }
#
# output "create_base_service_role_name" {
#   description = "Base service role name"
#   value       = aws_iam_role.base_service_role.name
# }
#
# output "create_base_service_role_arn" {
#   description = "Base service role ARN"
#   value       = aws_iam_role.base_service_role.arn
# }
#
# output "create_codebuild_service_role" {
#   description = "Base service role"
#   value       = aws_iam_role.codebuild_service_role
# }
#
# output "create_codebuild_service_role_name" {
#   description = "Base service role name"
#   value       = aws_iam_role.codebuild_service_role.name
# }
#
# output "create_codebuild_service_role_arn" {
#   description = "Base service role ARN"
#   value       = aws_iam_role.codebuild_service_role.arn
# }
#
# output "create_codepipeline_service_role" {
#   description = "Base service role"
#   value       = aws_iam_role.codepipeline_service_role
# }
#
# output "create_codepipeline_service_role_name" {
#   description = "Base service role name"
#   value       = aws_iam_role.codepipeline_service_role.name
# }
#
# output "create_codepipeline_service_role_arn" {
#   description = "Base service role ARN"
#   value       = aws_iam_role.codepipeline_service_role.arn
# }
#
# output "create_codepipeline_event_rule_role" {
#   description = "Base service role"
#   value       = aws_iam_role.codepipeline_event_rule_role
# }
#
# output "create_codepipeline_event_rule_role_name" {
#   description = "Base service role name"
#   value       = aws_iam_role.codepipeline_event_rule_role.name
# }
#
# output "create_codepipeline_event_rule_role_arn" {
#   description = "Base service role ARN"
#   value       = aws_iam_role.codepipeline_event_rule_role.arn
# }