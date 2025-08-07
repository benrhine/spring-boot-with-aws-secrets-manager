########################################################################################################################
# To view module outputs at runtime, outputs must be re-declared in root module outputs.tf.
########################################################################################################################
output "aws_codebuild_project" {
  description = "Returning CodeBuild Project"
  value       = aws_codebuild_project.codebuild_job
}

output "aws_codebuild_project_name" {
  description = "Returning CodeBuild Project"
  value       = aws_codebuild_project.codebuild_job.name
}

output "aws_codebuild_project_arn" {
  description = "Returning CodeBuild Project"
  value       = aws_codebuild_project.codebuild_job.arn
}