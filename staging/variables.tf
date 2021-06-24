variable "aws_region" {
  type = string
}

variable "aws_access_key_id" {
  type = string
}

variable "aws_secret_access_key" {
  type = string
}

variable "aws_availability_zones" {
  type        = list(string)
  description = "List of availability zones to use"
}

variable "api_docker_image" {
  type        = string
  description = "API docker image uri and tag in format <uri>:<tag>"
}

variable "service_name" {
  type        = string
  description = "Service name. Typically a username and app name combination like <username>:<app-name>. All AWS resources will be prefixed using this value"
}

variable "service_stage" {
  type        = string
  description = "Service stage: dev, staging, prod, etc. All AWS resources will contain this value"
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

variable "app_name" {
  type        = string
  description = "API name"
}

variable "app_stage" {
  type        = string
  description = "API stage"
}
