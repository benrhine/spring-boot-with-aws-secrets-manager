# What cloud platform are you using and what is the default region
provider "aws" {
  alias   = "brr-tools"
  region  = "us-east-2"
  shared_config_files      = ["~/.aws/config"]
  # shared_credentials_files = ["~/.aws/credentials"]
  profile = "brr-tools-admin"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-configuration-and-credentials-files
# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html#sso-configure-profile-auto
# https://dev.to/sepiyush/using-terraform-to-manage-resources-in-multiple-aws-accounts-1b61
# https://hector-reyesaleman.medium.com/terraform-aws-provider-everything-you-need-to-know-about-multi-account-authentication-and-f2343a4afd4b

provider "github" {
  owner = "benrhine"
  token = var.github_pat_2025
}
