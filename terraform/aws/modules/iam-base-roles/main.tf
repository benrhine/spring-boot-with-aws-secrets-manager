
# Import required modules
module "iam_policies" {
  source              = "../iam-policies"
  aws_region          = var.aws_region
  aws_account         = var.aws_account
  project_name        = var.project_name
  policy_resource_arn = aws_iam_role.base_assumed_service_role.arn
  deployment_bucket_name = var.deployment_bucket_name
  aws_codepipeline_project_name = var.aws_codepipeline_project_name
}

########################################################################################################################
# Create the assumed role
########################################################################################################################
# Naming Convention for resources:
# resource-type | resource-name
#
# resource-type: is predefined by terraform and can be referenced in the documentation
# resource-name: can be anything the user desires
#
# Recommendation: Use the resource-name to group like components of a given resource. i.e. unless something needs to be
# unique so that it can be declared in outputs.tf use the same resource-name for all related items
########################################################################################################################
resource "aws_iam_role" "base_assumed_service_role" {
  name = "tf-base-${var.aws_region}-assumed-service-role"
  description = "This is the base role that will be assumed"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Principal": {
              "AWS": "arn:aws:iam::792981815698:root"
          },
          "Action": "sts:AssumeRole"
      }
  ]
}
EOF
}

# THESE CAN NOT BE PUT IN A FOR EACH AS FOR EACH ONLY WORKS WITH VALUES THAT ARE ALREADY KNOWN

# 2. Attach managed policy
resource "aws_iam_role_policy_attachment" "base_assumed_service_role_1" {
  role       = aws_iam_role.base_assumed_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# 3.0 Create custom policy data in modules/iam-policies/data.tf via importing the module
# 3.1 Make data available as resource in modules/iam-policies/main.tf
# 3.2 Make created data available via modules/iam-policies/outputs.tf

# 4. Attache custom policy to role created in step 1.
resource "aws_iam_role_policy_attachment" "base_assumed_service_role_2" {
  role       = aws_iam_role.base_assumed_service_role.name
  policy_arn = module.iam_policies.tf_resource_iam_policy_arn

  depends_on = [
    module.iam_policies.tf_resource_iam_policy_arn
  ]
}

########################################################################################################################
# END create assumed role
########################################################################################################################

########################################################################################################################
# Create the base role
########################################################################################################################
# Naming Convention for resources:
# resource-type | resource-name
#
# resource-type: is predefined by terraform and can be referenced in the documentation
# resource-name: can be anything the user desires
#
# Recommendation: Use the resource-name to group like components of a given resource. i.e. unless something needs to be
# unique so that it can be declared in outputs.tf use the same resource-name for all related items
########################################################################################################################
resource "aws_iam_role" "base_service_role" {
  name = "tf-base-${var.aws_region}-service-role"
  description = "This is the base role that will be used to deploy resources"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "codepipeline.amazonaws.com",
                    "codebuild.amazonaws.com",
                    "cloudformation.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
  depends_on = [
    aws_iam_role.base_assumed_service_role
  ]
}

resource "aws_iam_role_policy_attachment" "base_service_role_1" {
  role       = aws_iam_role.base_service_role.name
  policy_arn = module.iam_policies.tf_resource_iam_policy_all_arn

  depends_on = [
    module.iam_policies.tf_resource_iam_policy_all_arn
  ]
}

resource "aws_iam_role_policy_attachment" "base_service_role_2" {
  role       = aws_iam_role.base_service_role.name
  policy_arn = module.iam_policies.tf_codebuild_resource_simple_policy_arn

  depends_on = [
    module.iam_policies.tf_codebuild_resource_simple_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "base_service_role_3" {
  role       = aws_iam_role.base_service_role.name
  policy_arn = module.iam_policies.tf_codepipeline_resource_policy_arn

  depends_on = [
    module.iam_policies.tf_codepipeline_resource_policy_arn
  ]
}
resource "aws_iam_role_policy_attachment" "base_service_role_4" {
  role       = aws_iam_role.base_service_role.name
  policy_arn = module.iam_policies.tf_ssm_policy_arn

  depends_on = [
    module.iam_policies.tf_ssm_policy_arn
  ]
}
resource "aws_iam_role_policy_attachment" "base_service_role_5" {
  role       = aws_iam_role.base_service_role.name
  policy_arn = module.iam_policies.tf_assume_role_policy_arn

  depends_on = [
    module.iam_policies.tf_assume_role_policy_arn
  ]
}

########################################################################################################################
# END create base role
########################################################################################################################

########################################################################################################################
# Create the CodeBuild service role
########################################################################################################################
# Naming Convention for resources:
# resource-type | resource-name
#
# resource-type: is predefined by terraform and can be referenced in the documentation
# resource-name: can be anything the user desires
#
# Recommendation: Use the resource-name to group like components of a given resource. i.e. unless something needs to be
# unique so that it can be declared in outputs.tf use the same resource-name for all related items
########################################################################################################################
resource "aws_iam_role" "codebuild_service_role" {
  name = "tf-${var.project_name}-${var.aws_region}-resource-deploy-service-role"
  description = "This is the base role that will be assumed"
  path = "/service-role/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Principal": {
              "Service": [
                  "codebuild.amazonaws.com"
              ]
          },
          "Action": "sts:AssumeRole"
      }
  ]
}
EOF
  depends_on = [
    aws_iam_role.base_assumed_service_role
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild_service_role_1" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = module.iam_policies.tf_log_policy_arn

  depends_on = [
    module.iam_policies.tf_log_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild_service_role_2" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = module.iam_policies.tf_log_group_build_policy_arn

  depends_on = [
    module.iam_policies.tf_log_group_build_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild_service_role_3" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = module.iam_policies.tf_s3_resource_policy_arn

  depends_on = [
    module.iam_policies.tf_s3_resource_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild_service_role_4" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = module.iam_policies.tf_codecommit_resource_repo_policy_arn

  depends_on = [
    module.iam_policies.tf_codecommit_resource_repo_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild_service_role_5" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = module.iam_policies.tf_codebuild_resource_policy_arn

  depends_on = [
    module.iam_policies.tf_codebuild_resource_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild_service_role_6" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = module.iam_policies.tf_domain_resources_codepipeline_policy_arn

  depends_on = [
    module.iam_policies.tf_domain_resources_codepipeline_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild_service_role_7" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = module.iam_policies.tf_resource_iam_pass_through_policy_arn

  depends_on = [
    module.iam_policies.tf_resource_iam_pass_through_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild_service_role_8" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = module.iam_policies.tf_ssm_get_policy_arn

  depends_on = [
    module.iam_policies.tf_ssm_get_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild_service_role_9" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = module.iam_policies.tf_assume_role_policy_arn

  depends_on = [
    module.iam_policies.tf_assume_role_policy_arn
  ]
}

########################################################################################################################
# END create CodeBuild service role
########################################################################################################################

########################################################################################################################
# Create the CodePipeline service role
########################################################################################################################
# Naming Convention for resources:
# resource-type | resource-name
#
# resource-type: is predefined by terraform and can be referenced in the documentation
# resource-name: can be anything the user desires
#
# Recommendation: Use the resource-name to group like components of a given resource. i.e. unless something needs to be
# unique so that it can be declared in outputs.tf use the same resource-name for all related items
########################################################################################################################
resource "aws_iam_role" "codepipeline_service_role" {
  name = "${var.project_name}-${var.aws_region}-codepipeline-role"
  description = "This is the base role that will be assumed"
  path = "/service-role/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Principal": {
              "Service": [
                  "codepipeline.amazonaws.com"
              ]
          },
          "Action": "sts:AssumeRole"
      }
  ]
}
EOF
  depends_on = [
    aws_iam_role.base_assumed_service_role
  ]
}

resource "aws_iam_role_policy_attachment" "codepipeline_service_role_1" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = module.iam_policies.tf_domain_resources_everything_policy_arn

  depends_on = [
    module.iam_policies.tf_domain_resources_everything_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "codepipeline_service_role_2" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = module.iam_policies.tf_domain_resources_s3_resource_policy_arn

  depends_on = [
    module.iam_policies.tf_domain_resources_s3_resource_policy_arn
  ]
}

resource "aws_iam_role_policy_attachment" "codepipeline_service_role_3" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = module.iam_policies.tf_assume_role_policy_arn

  depends_on = [
    module.iam_policies.tf_assume_role_policy_arn
  ]
}
########################################################################################################################
# END create CodePipeline service role
########################################################################################################################

resource "aws_iam_role" "codepipeline_event_rule_role" {
  name                = "tf-codepipeline-${var.aws_region}-event-rule-role"
  description         = "This role allows for the CodePipeline to execute"
  path                = "/"
  assume_role_policy  = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "events.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codepipeline_event_rule_role_1" {
  role       = aws_iam_role.codepipeline_event_rule_role.name
  policy_arn = module.iam_policies.tf_domain_resources_pipeline_execution_policy_arn

  depends_on = [
    module.iam_policies.tf_domain_resources_pipeline_execution_policy_arn
  ]
}
