variable "ecs_security_group_ids" {
  type        = list(string)
  description = "ECS security group ids for redis"
}

variable "redis_port" {
  type = number
}

variable "resource_prefix" {
  type = string
}
