########################################################################################################################
# To view module outputs at runtime, outputs must be re-declared in root module outputs.tf.
########################################################################################################################
output "tf_policy_arn" {
  description = "ARN of policy"
  value       = aws_iam_policy.policy.arn
}

# output "policy_arns" {
#   description = "IAM policies created"
#   value = [for policy in aws_iam_policy.policy : policy]
# }

# locals {
#   key_value_map = tomap({ for policy in aws_iam_policy.policy : policy.name => policy.arn })
# }

# output "policy_arns" {
# #   value = tomap({
# #     for k, inst in aws_iam_policy.policy : k => inst.id
# #   })
# #   value = [for policy in aws_iam_policy.policy : policy]
# #   value = local.key_value_map
#   value = { for name, bucket in aws_iam_policy.policy :  name > bucket.arn }
# }

# output "policy_arns" {
#   for_each = aws_iam_policy.policy # not expected here
# #   for_each = { for inst in aws_iam_policy.policy : inst.name => inst }
#   value = each
# #   for_each = { for inst in aws_iam_policy.policy : inst.name => inst }
# #   value                 = each
# }

# output "tf_resource_iam_policy_arn" {
#   description = "ARN of policy"
#   value       = {
#     arn = aws_iam_policy.policy.arn
#     name = aws_iam_policy.policy.name
#   }
# }


