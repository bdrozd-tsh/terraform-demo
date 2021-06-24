resource "aws_ecs_cluster" "main" {
  name = var.resource_prefix
}
