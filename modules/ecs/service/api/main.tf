resource "aws_ecs_service" "api" {
  name            = "${var.resource_prefix}-api"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.api.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_containers_count

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = aws_ecs_task_definition.api.family
    container_port   = var.container_port
  }

  network_configuration {
    subnets          = var.subnets_ids
    assign_public_ip = true
    security_groups  = [aws_security_group.api.id]
  }
}

resource "aws_ecs_task_definition" "api" {
  family = "${var.resource_prefix}-api"
  container_definitions = templatefile("${path.module}/../templates/api.json.tpl", {
    resource_prefix  = var.resource_prefix
    api_docker_image = var.api_docker_image
    container_port   = var.container_port
    host_port        = var.host_port
    memory           = var.memory
    cpu              = var.cpu
    aws_region       = var.aws_region
    rds_hostname     = var.rds_hostname
    redis_url        = var.redis_url
    rds_db_name      = var.rds_db_name
    rds_username     = var.rds_username
    rds_password     = var.rds_password
    app_name         = var.app_name
    app_stage        = var.app_stage
    aws_logs_group   = var.logs_group_name
  })
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = var.memory
  cpu                      = var.cpu
  execution_role_arn       = aws_iam_role.api.arn
}

resource "aws_iam_role" "api" {
  name               = "${var.resource_prefix}-api"
  assume_role_policy = data.aws_iam_policy_document.api_assume_role_policy.json
}

data "aws_iam_policy_document" "api_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "api" {
  role       = aws_iam_role.api.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_security_group" "api" {
  name = "${var.resource_prefix}-api"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = var.load_balancer_security_groups_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
