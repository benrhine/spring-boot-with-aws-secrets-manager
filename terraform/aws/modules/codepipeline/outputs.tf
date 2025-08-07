########################################################################################################################
# To view module outputs at runtime, outputs must be re-declared in root module outputs.tf.
########################################################################################################################
output "aws_codepipeline_project" {
  description = "Returning CodeBuild Project"
  value       = aws_codepipeline.codepipeline
}

output "aws_codepipeline_project_name" {
  description = "Returning CodeBuild Project"
  value       = aws_codepipeline.codepipeline.name
}

output "aws_codepipeline_project_arn" {
  description = "Returning CodeBuild Project"
  value       = aws_codepipeline.codepipeline.arn
}