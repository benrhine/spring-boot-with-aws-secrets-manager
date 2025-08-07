
resource "aws_codebuild_project" "codebuild_job" {
  name          = var.build_name
  description   = var.build_description
  build_timeout = var.build_timeout
  service_role  = var.service_role_arn    # Should be passed in via module declaration
  badge_enabled = var.build_badge_enabled       # Defaulted to true in variables.tf

# Depends on should be specified in root module main.tf module declaration
#   depends_on = [
#     var.service_role_arn
#   ]

  artifacts {
    type = var.artifacts  # Defaulted to true in variables.tf
  }

  environment {
    compute_type                = var.env_compute_type  # Defaulted to true in variables.tf
    image                       = var.env_image # Defaulted to true in variables.tf
    type                        = var.env_type  # Defaulted to true in variables.tf
    image_pull_credentials_type = var.env_image_pull_credentials_type # Defaulted to true in variables.tf
  }

  logs_config {
    cloudwatch_logs {
      status      = var.cloudwatch_logs #enabled # Defaulted to true in variables.tf
      group_name  = var.build_name
    }

    s3_logs {
      status   = var.s3_logs # disabled
    }
  }

  source {
    type            = var.git_source_type
    location        = var.git_repo_location
    buildspec       = var.git_repo_buildspec
    git_clone_depth = var.git_clone_depth # 0 Represents a full checkout which is necessary for git commands

    git_submodules_config {
      fetch_submodules = var.git_fetch_submodules
    }
  }

  source_version = var.git_source_version

  tags = {
    environment = var.env_tags_environment
    origination = var.env_tags_origination
  }
}