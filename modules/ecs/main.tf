resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.resource_prefix}-ecs-cluster"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.resource_prefix}-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_containers_count

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = aws_ecs_task_definition.ecs_task.family
    container_port   = var.container_port
  }

  network_configuration {
    subnets          = var.subnets_ids
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_security_group.id]
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "${var.resource_prefix}-task"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.resource_prefix}-task",
      "image": "${var.application_docker_image}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.host_port}
        }
      ],
      "memory": ${var.memory},
      "cpu": ${var.cpu}
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = var.memory
  cpu                      = var.cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.resource_prefix}-ecs-task-ex-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_security_group" "ecs_security_group" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    security_groups = var.load_balancer_security_groups_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

