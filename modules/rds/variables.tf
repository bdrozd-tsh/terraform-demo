variable "ecs_security_group_ids" {
  type        = list(string)
  description = "ECS security group ids for database"
}

variable "rds_port" {
  type = number
}

variable "rds_db_name" {
  type = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "resource_prefix" {
  type = string
}
