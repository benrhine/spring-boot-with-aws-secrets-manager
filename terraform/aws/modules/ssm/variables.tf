########################################################################################################################
# Variable must be defined in order for the module to receive the arn in order to limit which roles can assume the base
# role.
########################################################################################################################

variable "property_name" {
  description = "(Required) Name of the property"
  type        = string
}

variable "property_description" {
  description = "(Required) Description of the property"
  type        = string
}

variable "property_tier" {
  description = "Tier of the property"
  type        = string
  default     = "Standard"
}

variable "property_type" {
  description = "Type of the property"
  type        = string
  default     = "String"
}

variable "property_data_type" {
  description = "Data type of the property"
  type        = string
  default     = "text"
}

variable "property_value" {
  description = "(Required) Value of the property"
  type        = string
}

variable "property_tags_project" {
  description = "What project is this part of?"
  type        = string
  nullable    = true
  #   default = "" # By not setting a default makes it a required field UNLESS nullable is true
}

variable "property_tags_environment" {
  description = "What environment is this deployed to?"
  type        = string
  nullable    = true
}

variable "property_tags_origination" {
  description = "What repository is this deployed from?"
  type        = string
  nullable    = true
  #   default     = "INSERT-ENVIRONMENT-NAME"
}
