
# What cloud platform are you using and what is the default region
provider "aws" {
  region = "us-east-2"
  #   profile = "sandbox"
}

module "ssm_3" {
  # Where to find the module
  source                        = "../ssm"                                         # Where to find the module
  ######################################################################################################################
  property_name                 = "brr.tools.account.id"             # Custom defined value
  property_description          = "TOOLS Aws Account number" # Custom defined value
  property_value                = "XXXXXXXXXX"  # In order to use a value from a previous module the value must be exported in outputs.tf
  property_tags_environment     = var.environment_tag                                     # Value passed in via variables.tf
}