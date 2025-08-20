output "github_oidc_connection_arn" {
  description = "ARN of GitHub OIDC Connection"
  value       = aws_iam_openid_connect_provider.github.arn
}
