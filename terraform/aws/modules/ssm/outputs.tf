########################################################################################################################
# To view module outputs at runtime, outputs must be re-declared in root module outputs.tf.
########################################################################################################################
output "aws_ssm_property_arn" {
  description = "Created system manager property arn"
  value       = aws_ssm_parameter.create_system_manager_property.arn
}