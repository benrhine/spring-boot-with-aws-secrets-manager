########################################################################################################################
# Variable must be defined in order for the module to receive the arn in order to limit which roles can assume the base
# role.
########################################################################################################################

# Required
# variable "iam_policies_module" {}
#
# # variable "iam_policies_module" {
# #   type = object({ })
# # }
#
# # variable "iam_policies" {
# #   type = map(object({
# #     description = string
# #     value = string
# #   }))
# # }
#
# variable "base_assumed_service_role" {
#   description = "(Required) Aws role object"
# }
#
# variable "base_service_role" {
#   description = "(Required) Aws role object"
# }
#
# variable "codebuild_service_role" {
#   description = "(Required) Aws role object"
# }
#
# variable "codepipeline_service_role" {
#   description = "(Required) Aws role object"
# }
#
# variable "codepipeline_event_rule_role" {
#   description = "(Required) Aws role object"
# }

variable "role" {
  description = "(Required) Role name"
  type        = string
}

variable "policy_arn" {
  description = "(Required) Policy arn"
  type        = string
  default = ""
}

variable "policies" {
  description = "(Required) Policy arn"
  type        = list(string)
}