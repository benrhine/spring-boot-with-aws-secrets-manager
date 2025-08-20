
terraform {
  required_providers {
    # Configures access to AWS
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.42.0"
    }
    # Configures access to GitHub - ONLY REQUIRED to set GitHub Action secrets
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.12.2"

  # backend "s3" {
  #   bucket       = "idc-dpc-tf-state-0x1ga5mg"
  #   key          = "dpc-base-cloud-resources/terraform.tfstate"
  #   region       = "us-east-2"
  #   encrypt      = true
  #   use_lockfile = true #S3 native locking
  #   profile = "brr-np-admin"
  # }
}
