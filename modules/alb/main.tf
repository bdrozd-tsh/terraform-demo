resource "aws_alb" "application_load_balancer" {
  name               = "${var.resource_prefix}-lb"
  load_balancer_type = "application"
  subnets            = var.subnets_ids
  security_groups    = [aws_security_group.load_balancer_security_group.id]
}

resource "aws_security_group" "load_balancer_security_group" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allowing traffic in from all sources
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "${var.resource_prefix}-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.target_group_vpc_id
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}
