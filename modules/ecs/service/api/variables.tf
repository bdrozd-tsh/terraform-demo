variable "cluster_id" {
  type        = string
  description = "ECS cluster identifier"
}

variable "api_docker_image" {
  type        = string
  description = "API docker image uri and tag in format <uri>:<tag>"
}

variable "logs_group_name" {
  type = string
}

variable "desired_containers_count" {
  type        = number
  description = "Number of desired containers for ECS service"
}

variable "subnets_ids" {
  type        = list(string)
  description = "List of subnets identifiers for ECS service"
}

variable "load_balancer_target_group_arn" {
  type        = string
  description = "Load balancer target group ARN for ECS service"
}

variable "load_balancer_security_groups_ids" {
  type        = list(string)
  description = "Load balancer security groups identifiers for ECS security group"
}

variable "container_port" {
  type        = number
  description = "ECS container port"
}

variable "host_port" {
  type        = number
  description = "ECS host port"
}

variable "memory" {
  type        = number
  description = "ECS memory allocation"
}

variable "cpu" {
  type        = number
  description = "ECS cpu allocation"
}

variable "rds_db_name" {
  type = string
}

variable "rds_hostname" {
  type = string
}

variable "rds_port" {
  type = number
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "redis_url" {
  type = string
}

variable "app_name" {
  type        = string
  description = "Boilerplate application name"
}

variable "app_stage" {
  type        = string
  description = "Boilerplate application stage"
}

variable "aws_region" {
  type = string
}

variable "resource_prefix" {
  type = string
}
