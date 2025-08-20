# What cloud platform are you using and what is the default region
# provider "aws" {
#   alias   = "brr-tools"
#   region  = "us-east-2"
#   profile = "brr-tools-admin"
# }

provider "aws" {
  alias  = "brr-tools"
  region = "us-east-2"
  # profile = "brr-np-admin"
}

# TODO
# I believe these will have to be modified to receive client/secret from buildspec
# only reason the main one works this way is because it is initially executed from local