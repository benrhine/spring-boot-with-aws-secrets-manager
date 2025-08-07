########################################################################################################################
# Variable must be defined in order for the module to receive the arn in order to limit which roles can assume the base
# role.
########################################################################################################################

variable "event_rule_name" {
  description = "Name of event rule - event that triggers action"
  type        = string
}

variable "event_rule_description" {
  description = "Description of event rule"
  type        = string
}

variable "event_bus_name" {
  description = "Name of the event bus"
  type        = string
  default     = "default"
}

variable "event_bus_state" {
  description = "Is the bus enabled or disabled"
  type        = string
  default     = "ENABLED"
}

variable "event_pattern_source" {
  description = "Name of the event bus"
  type        = list(string)
  default     = ["aws.codecommit"]
}

variable "event_pattern_detail_type" {
  description = "Name of the event bus"
  type        = list(string)
  default     = ["CodeCommit Repository State Change"]
}

variable "event_pattern_resources" {
  description = "Name of the event bus"
  type        = list(string)
}

variable "event_pattern_detail_event" {
  description = "Name of the event bus"
  type        = list(string)
  default     = ["referenceCreated", "referenceUpdated"]
}

variable "event_pattern_detail_reference_type" {
  description = "Name of the event bus"
  type        = list(string)
  default     = ["branch"]
}

variable "event_pattern_detail_reference_name" {
  description = "Name of the event bus"
  type        = list(string)
  default     = ["main"]
}

// Event Target Variables
variable "aws_codepipeline_target_id" { # This value is used in the module data.tf
  description = "Which pipeline to execute on event"
  type        = string
}

variable "aws_codepipeline_project_arn" {
  description = "CodePipeline Project ARN"
  type        = string
}

variable "service_role_arn" { # This value is used in the module data.tf
  description = "Service role ARN required for execution"
  type        = string
}