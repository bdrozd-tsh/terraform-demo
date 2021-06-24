resource "aws_alb" "alb" {
  name               = "${var.resource_prefix}-lb"
  load_balancer_type = "application"
  subnets            = var.subnets_ids
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_security_group" "alb" {
  name = "${var.resource_prefix}-alb-security-group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "alb" {
  name        = "${var.resource_prefix}-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.target_group_vpc_id
  health_check {
    matcher = "200"
    path    = "/health"
  }
}

resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }
}
