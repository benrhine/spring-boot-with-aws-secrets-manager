########################################################################################################################
# To view module outputs at runtime, outputs must be re-declared in root module outputs.tf.
########################################################################################################################
output "event_rule_name" {
  description = "Event rule name"
  value       = aws_cloudwatch_event_rule.codepipeline_trigger.name
}

output "event_rule_arn" {
  description = "ARN of created event rule"
  value       = aws_cloudwatch_event_rule.codepipeline_trigger.arn
}

output "event_target_target_id" {
  description = "ARN of event rule target attachment"
  value       = aws_cloudwatch_event_target.codepipeline.target_id
}

output "event_target_arn" {
  description = "ARN of event rule target attachment"
  value       = aws_cloudwatch_event_target.codepipeline.arn
}