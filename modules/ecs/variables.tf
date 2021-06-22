variable "application_docker_image" {
  type        = string
  description = "Application docker image uri and tag in format <uri>:<tag>"
}

variable "desired_containers_count" {
  type = number
  description = "Number of desired containers for ECS service"
}

variable "subnets_ids" {
  type = list(string)
  description = "List of subnets identifiers for ECS service"
}

variable "load_balancer_target_group_arn" {
  type = string
  description = "Load balancer target group ARN for ECS service"
}

variable "load_balancer_security_groups_ids" {
  type = list(string)
  description = "Load balancer security groups identifiers for ECS security group"
}

variable "container_port" {
  type = number
  description = "ECS container port"
}

variable "host_port" {
  type = number
  description = "ECS host port"
}

variable "memory" {
  type = number
  description = "ECS memory allocation"
}

variable "cpu" {
  type = number
  description = "ECS cpu allocation"
}

variable "resource_prefix" {
  type = string
}
