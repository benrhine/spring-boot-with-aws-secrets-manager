

resource "aws_cloudwatch_event_rule" "codepipeline_trigger" {
  name              = var.event_rule_name
  description       = var.event_rule_description
  event_bus_name    = var.event_bus_name
  state             = var.event_bus_state

  event_pattern     = jsonencode({
    source          = var.event_pattern_source
    detail-type     = var.event_pattern_detail_type
    resources       = var.event_pattern_resources
    detail = {
      event         = var.event_pattern_detail_event
      referenceType = var.event_pattern_detail_reference_type
      referenceName = var.event_pattern_detail_reference_name
    }
  })
}

resource "aws_cloudwatch_event_target" "codepipeline" {
  rule              = aws_cloudwatch_event_rule.codepipeline_trigger.name
  target_id         = var.aws_codepipeline_target_id
  arn               = var.aws_codepipeline_project_arn
  role_arn          = var.service_role_arn
}
