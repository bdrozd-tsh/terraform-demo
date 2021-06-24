resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.resource_prefix}-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.5"
  port                 = var.redis_port
  security_group_ids   = [aws_security_group.redis.id]
}

resource "aws_security_group" "redis" {
  name = "${var.resource_prefix}-redis-security-group"

  ingress {
    protocol        = "tcp"
    from_port       = var.redis_port
    to_port         = var.redis_port
    security_groups = var.ecs_security_group_ids
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
