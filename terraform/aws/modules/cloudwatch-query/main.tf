
resource "aws_cloudwatch_query_definition" "create_cloudwatch_query" {
  name            = var.query_name
  log_group_names = var.query_log_group_names
  query_string    = var.query
}

# query_string = <<EOF
# fields @timestamp, @message
# | sort @timestamp desc
# | limit 25
# EOF