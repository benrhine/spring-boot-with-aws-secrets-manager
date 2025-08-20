# What cloud platform are you using and what is the default region
provider "aws" {
  # alias   = "brr-np"
  region  = "us-east-2"
  shared_config_files      = ["~/.aws/config"]
  # shared_credentials_files = ["~/.aws/credentials"]
  profile = "brr-np-admin"
}