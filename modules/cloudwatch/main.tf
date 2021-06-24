resource "aws_cloudwatch_log_group" "ecs" {
  name = "/ecs/${var.resource_prefix}"
}
