resource "aws_db_instance" "rds" {
  engine                 = "postgres"
  allocated_storage      = "8"
  instance_class         = "db.t2.micro"
  name                   = var.rds_db_name
  identifier             = "${var.resource_prefix}-postgres"
  username               = var.rds_username
  password               = var.rds_password
  vpc_security_group_ids = [aws_security_group.rds.id]
  port                   = var.rds_port
  skip_final_snapshot    = true // <- not recommended for production
}

resource "aws_security_group" "rds" {
  name = "${var.resource_prefix}-rds-security-group"

  ingress {
    protocol        = "tcp"
    from_port       = var.rds_port
    to_port         = var.rds_port
    security_groups = var.ecs_security_group_ids
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
