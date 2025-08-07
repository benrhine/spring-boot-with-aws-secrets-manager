
variable "query_name" {
  description = "Name of the saved query"
  type        = string
}

variable "query_log_group_names" {
  description = "(Optional) Specific log groups to query"
  type        = list(string)
  default     = []
}

variable "query" {
  description = "Query syntax"
  type        = string
}

# generalFindAllDebugQueryDefinition:
# Type: AWS::Logs::QueryDefinition
# Properties:
# Name: "general-find-all-debug"
# QueryString: 'DEBUG'

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-querydefinition.html